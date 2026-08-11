import blogatto/post.{type Post}
import elements
import gleam/list
import gleam/string
import gleam/time/timestamp
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn page(posts: List(Post(Nil))) -> Element(Nil) {
  let sorted_posts =
    list.sort(posts, fn(a, b) { timestamp.compare(b.date, a.date) })

  elements.page(
    "blog - sammyette's place",
    "",
    elements.Wide,
    elements.NavBlog,
    [
      html.div([attribute.class("font-serif text-4xl text-cream")], [
        element.text("journal"),
      ]),
      html.div([attribute.class("mt-8")], [
        html.input([
          attribute.type_("radio"),
          attribute.id("tag-filter-all"),
          attribute.name("tag-filter"),
          attribute.checked(True),
          attribute.class("peer/all sr-only"),
        ]),
        html.input([
          attribute.type_("radio"),
          attribute.id("tag-filter-coding"),
          attribute.name("tag-filter"),
          attribute.class("peer/coding sr-only"),
        ]),
        html.input([
          attribute.type_("radio"),
          attribute.id("tag-filter-games"),
          attribute.name("tag-filter"),
          attribute.class("peer/games sr-only"),
        ]),
        html.input([
          attribute.type_("radio"),
          attribute.id("tag-filter-life"),
          attribute.name("tag-filter"),
          attribute.class("peer/life sr-only"),
        ]),
        html.div(
          [
            attribute.id("tag-filter"),
            attribute.class(
              "flex gap-2.5 peer-checked/all:[&_[data-tag=all]]:border-accent peer-checked/all:[&_[data-tag=all]]:text-cream peer-checked/coding:[&_[data-tag=coding]]:border-accent peer-checked/coding:[&_[data-tag=coding]]:text-cream peer-checked/games:[&_[data-tag=games]]:border-accent peer-checked/games:[&_[data-tag=games]]:text-cream peer-checked/life:[&_[data-tag=life]]:border-accent peer-checked/life:[&_[data-tag=life]]:text-cream",
            ),
          ],
          [
            tag_filter_button("all", "tag-filter-all"),
            tag_filter_button("coding", "tag-filter-coding"),
            tag_filter_button("games", "tag-filter-games"),
            tag_filter_button("life", "tag-filter-life"),
          ],
        ),
        html.div(
          [
            attribute.id("post-list"),
            attribute.class(
              "flex flex-col mt-9 peer-checked/coding:[&_[data-tags]:not([data-tags~='coding'])]:hidden peer-checked/games:[&_[data-tags]:not([data-tags~='games'])]:hidden peer-checked/life:[&_[data-tags]:not([data-tags~='life'])]:hidden",
            ),
          ],
          list.map(sorted_posts, fn(p) {
            let tags = elements.post_tags(p)
            let primary = elements.primary_tag(p)
            html.div(
              [
                attribute.attribute("data-tags", string.join(tags, " ")),
                attribute.class(
                  "flex justify-between items-start gap-6 py-6 border-b border-border-soft",
                ),
              ],
              [
                html.div([], [
                  html.div([attribute.class("flex items-center gap-2.5")], [
                    html.a(
                      [
                        attribute.href("/blog/" <> p.slug <> "/"),
                        attribute.class(
                          "font-serif text-xl text-cream hover:text-accent",
                        ),
                      ],
                      [element.text(p.title)],
                    ),
                    elements.tag_pill(primary, elements.tag_color(primary)),
                  ]),
                  html.div(
                    [
                      attribute.class(
                        "font-sans text-[13.5px] text-muted mt-1.5 max-w-[560px]",
                      ),
                    ],
                    [element.text(p.description)],
                  ),
                ]),
                html.div(
                  [
                    attribute.class(
                      "font-mono text-xs text-muted whitespace-nowrap",
                    ),
                  ],
                  [element.text(elements.short_date(p.date))],
                ),
              ],
            )
          }),
        ),
      ]),
    ],
  )
}

fn tag_filter_button(tag: String, input_id: String) -> Element(msg) {
  html.label(
    [
      attribute.attribute("for", input_id),
      attribute.attribute("data-tag", tag),
      attribute.class(
        "font-mono text-xs rounded-full px-3.5 py-1.5 border border-border-strong text-muted bg-transparent cursor-pointer hover:border-accent transition-colors",
      ),
    ],
    [element.text(tag)],
  )
}
