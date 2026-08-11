import blogatto/post.{type Post}
import elements
import gleam/list
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn page(_posts: List(Post(Nil))) -> Element(Nil) {
  elements.page(
    "projects - sammyette's place",
    "",
    elements.Narrow,
    elements.NavProjects,
    [
      html.h1([attribute.class("font-serif text-4xl text-cream mb-2")], [
        element.text("projects"),
      ]),
      html.div([attribute.class("flex flex-col")], [
        project_row(
          "https://hilbish.sammyette.party/",
          "Hilbish",
          "A modern, advanced, comfortable Lua-configured (Unix/Windows) shell for everyone.",
          [#("go", "text-tag-coding"), #("lua", "text-tag-coding")],
          "active",
        ),
      ]),
    ],
  )
}

fn project_row(
  href: String,
  name: String,
  description: String,
  tags: List(#(String, String)),
  status: String,
) -> Element(msg) {
  html.div(
    [
      attribute.class(
        "py-7 border-b border-border-soft flex justify-between gap-6",
      ),
    ],
    [
      html.div([], [
        html.a(
          [
            attribute.href(href),
            attribute.class(
              "font-serif text-[22px] text-cream hover:text-accent",
            ),
          ],
          [element.text(name)],
        ),
        html.p(
          [
            attribute.class(
              "font-sans text-sm leading-[1.7] text-body max-w-[520px] mt-2 mb-0",
            ),
          ],
          [element.text(description)],
        ),
        html.div(
          [attribute.class("flex gap-2 mt-3")],
          list.map(tags, fn(t) { elements.tag_pill(t.0, t.1) }),
        ),
      ]),
      html.span(
        [attribute.class("font-mono text-xs text-muted whitespace-nowrap")],
        [element.text(status)],
      ),
    ],
  )
}
