import glaml
import gleam/io
import gleam/list
import gleam/string
import lustre/attribute
import lustre/element/html
import lustre/ssg
import lustre/ssg/djot
import pages/index
import post
import simplifile

pub fn main() {
  let assert Ok(files) = simplifile.get_files("./content")
  let posts =
    list.map(files, fn(path: String) {
      let assert Ok(ext) = path |> string.split(".") |> list.last
      let slug =
        path
        |> string.replace("./content", "")
        |> string.drop_end({ ext |> string.length() } + 1)
      let assert Ok(name) = slug |> string.split("/") |> list.last

      let slug = case name {
        "_index" -> slug |> string.drop_end({ "_index" |> string.length() } + 1)
        _ -> slug
      }

      let assert Ok(content) = simplifile.read(path)

      let metadata = case djot.frontmatter(content) {
        Ok(frontmatter) -> {
          let assert Ok([metadata]) = glaml.parse_string(frontmatter)
          metadata |> glaml.document_root
        }
        Error(_) -> glaml.NodeMap([])
      }
      let title = case metadata |> glaml.select_sugar("title") {
        Ok(glaml.NodeStr(title)) -> title
        _ -> ""
      }
      let description = case metadata |> glaml.select_sugar("description") {
        Ok(glaml.NodeStr(description)) -> description
        _ -> ""
      }

      let assert Ok(filename) = path |> string.split("/") |> list.last
      let content = djot.content(content)
      #(slug, post.Post(name, description, title, slug, metadata, content))
    })

  let build =
    ssg.new("./public")
    |> ssg.add_static_route("/", setup_page(index.page()))
    |> ssg.use_index_routes
    |> ssg.build

  case build {
    Ok(_) -> io.println("Website built!")
    Error(e) -> {
      io.println_error("Website didn't build :(")
      echo e
      Nil
    }
  }
}

fn setup_page(page) {
  html.html([attribute.class("light dark:bg-zinc-800 light:bg-zinc-100")], [
    html.head([], [
      html.meta([
        attribute.name("viewport"),
        attribute.attribute("content", "width=device-width, initial-scale=1.0"),
      ]),
      html.link([
        attribute.rel("stylesheet"),
        attribute.href("/tailwind.css"),
      ]),
      // Fonts
      html.link([
        attribute.href("https://fonts.googleapis.com"),
        attribute.rel("preconnect"),
      ]),
      html.link([
        attribute.attribute("crossorigin", ""),
        attribute.href("https://fonts.gstatic.com"),
        attribute.rel("preconnect"),
      ]),
      html.link([
        attribute.rel("stylesheet"),
        attribute.href(
          "https://fonts.googleapis.com/css2?family=Azeret+Mono:ital,wght@0,100..900;1,100..900&family=Pacifico&family=Poppins:wght@100;200;300;400;500;600;700;800&display=swap",
        ),
      ]),
    ]),
    page,
  ])
}
