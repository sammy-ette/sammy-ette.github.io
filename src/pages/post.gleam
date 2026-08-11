import blogatto/post.{type Post}
import elements
import gleam/list
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn template(p: Post(Nil), _all_posts: List(Post(Nil))) -> Element(Nil) {
  let tags = elements.post_tags(p)
  let primary = elements.primary_tag(p)

  elements.page(
    p.title <> " - sammyette's place",
    p.description,
    elements.Narrow,
    elements.NavBlog,
    [
      html.a(
        [
          attribute.href("/blog"),
          attribute.class("font-mono text-xs text-muted hover:text-accent"),
        ],
        [element.text("← back to journal")],
      ),
      html.div([attribute.class("flex items-center gap-2.5 mt-6")], [
        elements.tag_pill(primary, elements.tag_color(primary)),
        html.span([attribute.class("font-mono text-xs text-muted")], [
          element.text(elements.short_date(p.date)),
        ]),
      ]),
      html.h1(
        [
          attribute.class(
            "font-serif text-[38px] leading-tight text-cream mt-4 mb-2",
          ),
        ],
        [element.text(p.title)],
      ),
      html.div([attribute.class("font-sans text-sm text-muted mb-9")], [
        element.text(p.description),
      ]),
      html.div([attribute.class("font-sans")], p.contents),
      case tags {
        [] -> element.fragment([])
        _ ->
          html.div(
            [attribute.class("flex gap-2 mt-3")],
            list.map(tags, fn(t) { elements.tag_pill(t, elements.tag_color(t)) }),
          )
      },
    ],
  )
}
