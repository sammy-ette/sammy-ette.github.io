import blogatto/post.{type Post}
import elements
import gleam/list
import gleam/time/timestamp
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn page(posts: List(Post(Nil))) -> Element(Nil) {
  let latest =
    posts
    |> list.sort(fn(a, b) { timestamp.compare(b.date, a.date) })
    |> list.take(3)

  let hero =
    html.div([attribute.class("flex gap-8 min-h-[230px]")], [
      html.div(
        [
          attribute.class(
            "w-[460px] shrink-0 rotate-[-1.2deg] rounded-sm border border-border-strong bg-surface px-8 py-6 shadow-2xl",
          ),
          attribute.style(
            "background-image",
            "repeating-linear-gradient(oklch(0.20 0.038 285) 0 27px, oklch(0.28 0.04 285) 27px 28px)",
          ),
        ],
        [
          html.div([attribute.class("font-serif text-xl text-cream mb-2.5")], [
            element.text("hi, i'm sammy."),
          ]),
          html.p(
            [attribute.class("font-sans text-sm leading-7 text-cream m-0")],
            [
              element.text(elements.bio_intro()),
              element.text(" Have a peek "),
              link("/about", "here"),
              element.text(" for more info about me!"),
            ],
          ),
          html.div(
            [attribute.class("font-mono text-xs text-tag-coding mt-3.5")],
            [
              element.text("currently: rewriting this website (again)"),
            ],
          ),
          html.div(
            [
              attribute.class("font-mono text-xs text-muted mt-2 flex gap-2.5"),
            ],
            [
              link("https://github.com/sammy-ette", "github"),
              element.text("✦"),
              link("https://discord.gg/XFjvAtqg2S", "discord"),
              element.text("✦"),
              link("https://myanimelist.net/profile/sammyette", "mal"),
            ],
          ),
        ],
      ),
      html.div(
        [
          attribute.class(
            "w-[160px] shrink-0 bg-paper pt-2.5 px-2.5 pb-6 rotate-[2.2deg] shadow-2xl",
          ),
        ],
        [
          html.img([
            attribute.class("w-full h-[140px] object-cover block"),
            attribute.src("/img/profile.png"),
            attribute.alt("sammy"),
          ]),
          html.div(
            [
              attribute.class(
                "font-serif text-xs text-paper-ink text-center mt-2",
              ),
            ],
            [element.text("sammy, 2026")],
          ),
        ],
      ),
      html.div(
        [attribute.class("flex-1 min-w-0 flex flex-wrap content-start gap-3")],
        [
          web_button("/buttons/sammyette.png", "", "my web button"),
          web_button("https://webb.is-a.dev/8831.png", "https://webb.is-a.dev/", "iris web button"),
          web_button(
            "https://highway.eightyeightthirty.one/badge/b74bd1a92112547b96015f56e01a26b565fde25a33897ca3917b9f6d0eb6702e",
            "https://gleam.run",
            "made with Gleam",
          ),
          web_button("/buttons/steam.gif", "", "steam fever web button"),
          web_button("/buttons/3ds.png", "", "3ds web button"),
          web_button("/buttons/az_1.gif", "", "grade a web button"),
          web_button("/buttons/fantasy.gif", "", "fantasy web button"),
          web_button("/buttons/fb.png", "", "fibre! web button"),
          web_button("/buttons/gimp.gif", "", "gimp web button"),
          web_button("/buttons/godot.png", "", "godot web button"),
          web_button(
            "/buttons/kawaiinightmare.gif",
            "",
            "kawaiinightmare web button",
          ),
          web_button("/buttons/keeper.png", "", "im a keeper web button"),
          web_button("/buttons/linux.gif", "", "linux web button"),
          web_button("/buttons/minecraft.gif", "", "minecraft web button"),
          web_button(
            "/buttons/microbar.gif",
            "",
            "peko-chan micro bar web button",
          ),
          web_button(
            "/buttons/perfected.gif",
            "",
            "perfect edition web button",
          ),
          web_button(
            "/buttons/sm_fever_button.gif",
            "",
            "sailor moon fever web button",
          ),
          web_button(
            "/buttons/stardew_valley.gif",
            "",
            "stardew valley web button",
          ),
          web_button("/buttons/stop.gif", "", "stop windows web button"),
          web_button(
            "/buttons/vsc.gif",
            "",
            "visual studio code web button",
          ),
          web_button(
            "/buttons/best_chrome.gif",
            "",
            "best on chrome web button",
          ),
        ],
      ),
    ])

  let journal =
    html.div([], [
      html.div([attribute.class("font-serif text-[17px] text-cream mb-3")], [
        element.text("journal"),
      ]),
      html.div(
        [attribute.class("flex flex-col gap-3")],
        list.map(latest, fn(p) {
          let primary = elements.primary_tag(p)
          html.div([attribute.class("flex justify-between gap-4")], [
            html.div([], [
              html.div([attribute.class("flex items-center gap-2")], [
                html.a(
                  [
                    attribute.href("/blog/" <> p.slug <> "/"),
                    attribute.class(
                      "font-serif text-[17px] text-cream hover:text-accent",
                    ),
                  ],
                  [element.text(p.title)],
                ),
                elements.tag_pill(primary, elements.tag_color(primary)),
              ]),
              html.div(
                [attribute.class("font-sans text-[13px] text-muted mt-1")],
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
          ])
        }),
      ),
    ])

  elements.page(
    "sammyette's place",
    "",
    elements.Wide,
    elements.NavHome,
    [
      hero,
      html.div([attribute.class("mt-6")], [journal]),
    ],
  )
}

fn web_button(
  img_src: String,
  href: String,
  alt: String
) -> Element(msg) {
  let img =
    html.img([
      attribute.src(img_src),
      attribute.alt(alt),
      attribute.width(88),
      attribute.height(31),
    ])

  case href {
    "" -> img
    _ ->
      html.a(
        [
          attribute.href(href),
          attribute.class("h-fit"),
        ],
        [img],
      )
  }
}

fn link(href: String, label: String) -> Element(msg) {
  html.a(
    [attribute.href(href), attribute.class("text-muted hover:text-accent")],
    [element.text(label)],
  )
}
