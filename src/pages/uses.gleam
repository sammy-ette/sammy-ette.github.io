import blogatto/post.{type Post}
import elements
import gleam/list
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn page(_posts: List(Post(Nil))) -> Element(Nil) {
  let software =
    html.div([], [
      section_title("software"),
      html.div(
        [
          attribute.class(
            "flex flex-col gap-3.5 font-sans text-sm text-body [&>*:last-child]:border-b-0",
          ),
        ],
        [
          spec_row("editor", "Zed"),
          spec_row("shell", "Hilbish (i made this btw)"),
          spec_row("os", "Fedora Linux"),
          spec_row("terminal", "tym"),
          spec_row("window manager", "awesome"),
        ],
      ),
    ])

  let hardware =
    html.div([attribute.class("mt-11")], [
      section_title("hardware"),
      html.div([attribute.class("grid grid-cols-2 gap-14 mb-9")], [
        html.div([], [
          html.div([attribute.class("font-serif text-base text-cream mb-3")], [
            element.text("laptop"),
          ]),
          html.div(
            [
              attribute.class(
                "flex flex-col gap-2.5 font-mono text-[13px] text-body [&>*:last-child]:border-b-0",
              ),
            ],
            list.map(
              [
                #("CPU", "Intel Core i7-1195G7"),
                #("GPU", "Intel Iris Xe Graphics (integrated)"),
                #("RAM", "16GB"),
              ],
              fn(spec) {
                html.div(
                  [
                    attribute.class(
                      "flex justify-between border-b border-border-soft pb-2",
                    ),
                  ],
                  [
                    html.span([attribute.class("text-muted")], [
                      element.text(spec.0),
                    ]),
                    html.span([], [element.text(spec.1)]),
                  ],
                )
              },
            ),
          ),
        ]),
        html.div([], [
          html.div([attribute.class("font-serif text-base text-cream mb-3")], [
            element.text("pc"),
          ]),
          html.div([attribute.class("font-mono text-xs text-muted italic")], [
            element.text("still need to fill this in."),
          ]),
        ]),
      ]),
      html.div([attribute.class("font-serif text-base text-cream mb-1")], [
        element.text("keyboard"),
      ]),
      html.div([attribute.class("font-sans text-sm text-body mb-4")], [
        element.text("Ajazz AK820 Pro"),
      ]),
      placeholder_box("w-full h-[280px]", "picture coming soon"),
    ])

  let window_manager_setup =
    html.div([attribute.class("mt-11")], [
      section_title("window manager setup"),
      html.div(
        [attribute.class("font-sans text-sm leading-[1.8] text-body mb-4")],
        [
          element.text(
            "I run awesome (X11) on both machines. Config and the rest of my dotfiles are on ",
          ),
          html.a(
            [
              attribute.href("https://github.com/sammy-ette/dotfiles"),
              attribute.class("text-accent hover:text-cream"),
            ],
            [element.text("GitHub")],
          ),
          element.text("."),
        ],
      ),
      placeholder_box("w-full h-[340px]", "screenshot coming soon"),
    ])

  elements.page(
    "uses - sammyette's place",
    "",
    elements.Narrow,
    elements.NavUses,
    [
      html.h1([attribute.class("font-serif text-4xl text-cream mb-2")], [
        element.text("uses"),
      ]),
      software,
      hardware,
      window_manager_setup,
    ],
  )
}

fn section_title(label: String) -> Element(msg) {
  html.div([attribute.class("font-serif text-[17px] text-cream mb-4")], [
    element.text(label),
  ])
}

fn spec_row(label: String, value: String) -> Element(msg) {
  html.div(
    [
      attribute.class("flex justify-between border-b border-border-soft pb-2.5"),
    ],
    [
      html.span([attribute.class("text-muted")], [element.text(label)]),
      html.span([], [element.text(value)]),
    ],
  )
}

fn placeholder_box(size_classes: String, label: String) -> Element(msg) {
  html.div(
    [
      attribute.class(size_classes),
      attribute.class(
        "flex-shrink-0 border border-dashed border-border-strong rounded flex items-center justify-center text-center px-3",
      ),
    ],
    [
      html.span([attribute.class("font-mono text-xs text-muted")], [
        element.text(label),
      ]),
    ],
  )
}
