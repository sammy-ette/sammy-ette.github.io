import gleam/list
import lustre/attribute
import lustre/element
import lustre/element/html

// #f45b69

pub fn page() {
  html.body([], [
    html.div([attribute.class("h-screen flex flex-col")], [
      html.div(
        [attribute.class("flex-1 flex flex-col items-center justify-center")],
        [
          html.div([attribute.class("flex flex-col items-center")], [
            html.img([
              attribute.class("w-24 h-24 rounded-full"),
              attribute.src(
                "https://avatars1.githubusercontent.com/u/38820196?s=460&u=b9f4efb2375bae6cb30656d790c6e0a2939327c0&v=4",
              ),
            ]),
            html.h1(
              [
                attribute.class(
                  "font-[Pacifico,cursive] text-5xl text-[#f45b69]",
                ),
              ],
              [element.text("sammyette")],
            ),
          ]),
          nav([attribute.class("m-4")]),
          html.p([], [
            element.text("I make things: "),
            html.a(
              [
                attribute.class("text-[#f45b69] hover:underline"),
                attribute.href("https://github.com/sammy-ette"),
              ],
              [
                element.text("websites, software"),
              ],
            ),
            element.text(", graphic work."),
            html.br([]),
            element.text("scroll if you want to know more!"),
          ]),
        ],
      ),
    ]),
    html.div(
      [
        attribute.class(
          "border-t border-[#f45b69] p-2 my-3 max-w-[58rem] mx-auto",
        ),
        attribute.id("about-me"),
      ],
      [
        html.h1([attribute.class("font-bold font-[Poppins] text-2xl")], [
          html.a([attribute.href("#about-me")], [
            html.span([attribute.class("hover:underline text-[#f45b69]")], [
              element.text("%"),
            ]),
          ]),
          element.text(" about me"),
        ]),
        html.p([], [
          element.text(
            "
        I'm a person who likes sitting in my room all day using my electronic devices, whether
        it's for programming, playing games, or watching another anime from my ever-growing plan
        to watch list.

        I started this at a young age, initially writing things in JavaScript, but currently I
        enjoy using Go, Lua and Gleam. Hilbish, my biggest project, uses all 3 of those languages!
        ",
          ),
        ]),
      ],
    ),
    html.div(
      [
        attribute.class(
          "border-t border-[#f45b69] p-2 my-3 max-w-[58rem] mx-auto",
        ),
        attribute.id("hobbies"),
      ],
      [
        html.h1([attribute.class("font-bold font-[Poppins] text-2xl")], [
          html.a([attribute.href("#hobbies")], [
            html.span([attribute.class("hover:underline text-[#f45b69]")], [
              element.text("%"),
            ]),
          ]),
          element.text(" hobbies"),
        ]),
        html.ul([attribute.class("list-inside list-disc px-2")], [
          html.li([], [
            html.a(
              [
                attribute.class("hover:underline text-[#f45b69]"),
                attribute.href("https://github.com/sammy-ette"),
              ],
              [element.text("writing software")],
            ),
          ]),
          html.li([], [
            html.a(
              [
                attribute.class("hover:underline text-[#f45b69]"),
                attribute.href("https://myanimelist.net/profile/sammyette"),
              ],
              [element.text("watching anime")],
            ),
          ]),
          html.li([], [
            html.a(
              [
                attribute.class("hover:underline text-[#f45b69]"),
                attribute.href("https://mydramalist.com/profile/TorchedSammy"),
              ],
              [element.text("watching asian drama")],
            ),
          ]),
          html.li([], [
            html.a(
              [
                attribute.class("hover:underline text-[#f45b69]"),
                attribute.href("https://osu.ppy.sh/users/15003952"),
              ],
              [
                element.text("osu!"),
              ],
            ),
            element.text(" i am #1 in my country, but i'm also just 6 digit."),
          ]),
          html.li([], [
            html.a(
              [
                attribute.class("hover:underline text-[#f45b69]"),
                attribute.href("https://backloggd.com/u/sammyette/"),
              ],
              [
                element.text(
                  "playing every retro game as a personal challenge.",
                ),
              ],
            ),
            element.text(" if you want to see my progress, "),
            html.a([attribute.href("https://discord.gg/XFjvAtqg2S")], [
              element.text("join my discord!"),
            ]),
          ]),
        ]),
      ],
    ),
  ])
}

fn nav(attrs: List(attribute.Attribute(a))) {
  html.nav(
    [
      attribute.class(
        "p-2 justify-center items-center flex border-b border-[#f45b69] gap-3",
      ),
      ..attrs
    ],
    [
      html.a([attribute.href("/")], [element.text("home")]),
      html.a([attribute.href("/blog")], [element.text("blog")]),
      html.a([attribute.href("/hire-me"), attribute.class("font-bold")], [
        element.text("hire me!"),
      ]),
    ],
  )
}
