import argv
import gleam/io
import gleam/list
import gleam/string
import shellout
import simplifile

const usage = "Usage: gleam run -m new_post -- --title \"Post Title\" [--description \"...\"] [--tags \"coding, rust\"]"

type Options {
  Options(title: String, description: String, tags: String)
}

///   gleam run -m new_post -- --title "Post Title" --description "..." --tags "coding, rust"
pub fn main() {
  let opts =
    parse_args_loop(
      argv.load().arguments,
      Options(title: "", description: "", tags: ""),
    )

  case opts.title {
    "" -> io.println(usage)
    title -> {
      let slug = slugify(title)
      let dir = "./blog/" <> slug
      let path = dir <> "/index.md"

      case simplifile.is_file(path) {
        Ok(True) -> io.println_error("A post already exists at " <> path)
        _ ->
          case
            shellout.command(
              run: "date",
              with: ["+%Y-%m-%d %H:%M:%S %:z"],
              in: ".",
              opt: [],
            )
          {
            Error(#(_, message)) ->
              io.println_error("Couldn't get the current date: " <> message)
            Ok(output) -> {
              let frontmatter =
                "---\n"
                <> "title: \""
                <> title
                <> "\"\n"
                <> "date: "
                <> string.trim(output)
                <> "\n"
                <> "slug: \""
                <> slug
                <> "\"\n"
                <> "description: \""
                <> opts.description
                <> "\"\n"
                <> "tags: \""
                <> opts.tags
                <> "\"\n"
                <> "---\n\n"

              let assert Ok(_) = simplifile.create_directory_all(dir)

              case simplifile.write(to: path, contents: frontmatter) {
                Ok(_) -> io.println("Created new post at " <> path)
                Error(err) ->
                  io.println_error(
                    "Couldn't write post: " <> simplifile.describe_error(err),
                  )
              }
            }
          }
      }
    }
  }
}

fn parse_args_loop(args: List(String), opts: Options) -> Options {
  case args {
    ["--title", value, ..rest] ->
      parse_args_loop(rest, Options(..opts, title: value))
    ["--description", value, ..rest] ->
      parse_args_loop(rest, Options(..opts, description: value))
    ["--tags", value, ..rest] ->
      parse_args_loop(rest, Options(..opts, tags: value))
    [_, ..rest] -> parse_args_loop(rest, opts)
    [] -> opts
  }
}

fn slugify(title: String) -> String {
  let graphemes = title |> string.lowercase |> string.to_graphemes

  let #(slug, _) =
    list.fold(graphemes, #("", True), fn(acc, grapheme) {
      let #(result, last_was_sep) = acc
      let is_alnum = case string.to_utf_codepoints(grapheme) {
        [codepoint] -> {
          let code = string.utf_codepoint_to_int(codepoint)
          { code >= 48 && code <= 57 } || { code >= 97 && code <= 122 }
        }
        _ -> False
      }

      case is_alnum {
        True -> #(result <> grapheme, False)
        False ->
          case last_was_sep {
            True -> acc
            False -> #(result <> "-", True)
          }
      }
    })

  case string.ends_with(slug, "-") {
    True -> string.drop_end(slug, 1)
    False -> slug
  }
}
