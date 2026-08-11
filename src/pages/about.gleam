import blogatto/post.{type Post}
import elements
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn page(_posts: List(Post(Nil))) -> Element(Nil) {
  elements.page(
    "about - sammyette's place",
    "",
    elements.Narrow,
    elements.NavAbout,
    [
      html.div([attribute.class("relative min-h-[180px]")], [
        html.div(
          [
            attribute.class(
              "absolute top-0 left-0 w-[150px] bg-paper pt-2.5 px-2.5 pb-6 rotate-[-2deg] shadow-2xl",
            ),
          ],
          [
            html.img([
              attribute.class("w-full h-[130px] object-cover block"),
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
        html.div([attribute.class("ml-[190px]")], [
          html.h1(
            [attribute.class("font-serif text-[34px] text-cream m-0 mb-3")],
            [
              element.text("about"),
            ],
          ),
          html.p(
            [
              attribute.class(
                "font-sans text-[15.5px] leading-[1.75] text-body m-0",
              ),
            ],
            [
              element.text(
                "I'm sammyette, also known as sammy or (formerly) TorchedSammy. I spend my free time engaging in various hobbies: programming, gaming, watching anime/kdrama, and taking photos.",
              ),
            ],
          ),
        ]),
      ]),
      html.div(
        [attribute.class("font-sans text-base leading-[1.85] text-body mt-11")],
        [
          html.p([attribute.class("m-0 mb-[22px]")], [
            element.text("My introduction to programming (that I can remember) started when I was creating Discord bots in Javascript.. (ew, i know). "),
            element.text("These days, I actually do programming as a job, which means when I get home I don't want to touch another piece of code. "),
            element.text("I still do though, sometimes. My personal projects use the 3 languages I like the most: Go, Lua, and Gleam.")
          ]),
          html.p([attribute.class("m-0 mb-[22px]")], [
            element.text("Outside of code I'm usually watching "),
            html.a(
              [
                attribute.href("https://myanimelist.net/profile/sammyette"),
                attribute.class("text-accent hover:text-cream"),
              ],
              [element.text("anime")],
            ),
            element.text(" or grinding through "),
            html.a(
              [
                attribute.href("https://backloggd.com/u/sammyette/"),
                attribute.class("text-accent hover:text-cream"),
              ],
              [element.text("every retro game as a personal challenge.")],
            ),
          ]),
        ],
      ),
    ],
  )
}
