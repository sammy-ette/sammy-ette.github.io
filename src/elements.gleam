import blogatto/post.{type Post}
import gleam/dict
import gleam/int
import gleam/list
import gleam/string
import gleam/time/calendar
import gleam/time/timestamp.{type Timestamp}
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub type Nav {
  NavHome
  NavBlog
  NavProjects
  NavUses
  NavAbout
}

pub type Width {
  Wide
  Narrow
}

pub fn page(
  title: String,
  description: String,
  width: Width,
  active: Nav,
  content: List(Element(msg)),
) -> Element(msg) {
  html.html([attribute.class("dark")], [
    head(title, description),
    html.body([attribute.class("m-0 bg-ink font-sans")], [
      html.div([attribute.class("min-h-screen flex flex-col bg-ink")], [
        html.div(
          [
            attribute.class("flex-1 w-full mx-auto pt-8 pb-6"),
            case width {
              Wide -> attribute.class("max-w-[1180px] px-16")
              Narrow -> attribute.class("max-w-[900px] px-10")
            },
          ],
          [
            header(width, active),
            html.div([attribute.class("h-px bg-border my-6")], []),
            ..content
          ],
        ),
        marquee(),
      ]),
    ]),
  ])
}

fn head(title: String, description: String) -> Element(msg) {
  html.head([], [
    html.meta([attribute.charset("UTF-8")]),
    html.meta([
      attribute.name("viewport"),
      attribute.content("width=device-width, initial-scale=1.0"),
    ]),
    html.title([], title),
    html.meta([attribute.name("description"), attribute.content(description)]),
    html.link([attribute.rel("stylesheet"), attribute.href("/tailwind.css")]),
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
        "https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=Work+Sans:wght@400;500;600&family=JetBrains+Mono:wght@400;500&display=swap",
      ),
    ]),
  ])
}

fn header(width: Width, active: Nav) -> Element(msg) {
  let brand = [
    html.img([
      attribute.class("rounded-full object-cover border border-border-avatar"),
      case width {
        Wide -> attribute.class("w-12 h-12")
        Narrow -> attribute.class("w-11 h-11")
      },
      attribute.src("/img/profile.png"),
      attribute.alt("sammy's avatar"),
    ]),
    case width {
      Wide ->
        html.div([], [
          html.div(
            [attribute.class("font-serif text-[26px] text-cream leading-none")],
            [
              element.text("sammyette"),
            ],
          ),
          html.div([attribute.class("text-sm text-muted mt-1.5")], [
            element.text("software engineer & anime/music/gaming enjoyer"),
          ]),
        ])
      Narrow ->
        html.div([attribute.class("font-serif text-[22px] text-cream")], [
          element.text("sammyette"),
        ])
    },
  ]

  let nav_text_size = case width {
    Wide -> "text-sm"
    Narrow -> "text-[13px]"
  }
  html.div([attribute.class("flex items-center justify-between gap-6")], [
    html.a(
      [attribute.href("/"), attribute.class("flex items-center gap-4")],
      brand,
    ),
    html.nav(
      [
        attribute.class("flex"),
        case width {
          Wide -> attribute.class("gap-7")
          Narrow -> attribute.class("gap-6")
        },
      ],
      [
        nav_link("blog", "/blog", nav_text_size, active == NavBlog),
        nav_link("projects", "/projects", nav_text_size, active == NavProjects),
        nav_link("uses", "/uses", nav_text_size, active == NavUses),
        nav_link("about", "/about", nav_text_size, active == NavAbout),
        nav_link("rss", "/atom.xml", nav_text_size, False),
      ],
    ),
  ])
}

fn nav_link(
  label: String,
  href: String,
  text_size: String,
  is_active: Bool,
) -> Element(msg) {
  html.a(
    [
      attribute.href(href),
      attribute.class(text_size),
      case is_active {
        True -> attribute.class("text-cream font-semibold")
        False -> attribute.class("text-muted hover:text-accent")
      },
    ],
    [element.text(label)],
  )
}

fn marquee() -> Element(msg) {
  let phrase =
    "★ © sammyette 2026 ★ est. 2021 ★ retro gaming ★ possible weeb ★ anything music enjoyer ★ ᗜˬᗜ fumo ★ kpop ^_^ ★ asian drama enthusiast ★ "
  html.div(
    [
      attribute.class(
        "overflow-hidden whitespace-nowrap bg-ink-2 border-t border-border py-1.5",
      ),
    ],
    [
      html.div(
        [
          attribute.class(
            "inline-block marquee-track font-mono text-xs text-muted",
          ),
        ],
        [element.text(phrase <> phrase)],
      ),
    ],
  )
}

pub fn tag_pill(label: String, color_class: String) -> Element(msg) {
  html.span(
    [
      attribute.class(
        "font-mono text-[10px] rounded px-1.5 py-0.5 bg-surface-2",
      ),
      attribute.class(color_class),
    ],
    [element.text(label)],
  )
}

pub fn bio_intro() -> String {
  "I like staying in with my electronic devices and programming, gaming, or watching another anime episode."
}

pub fn tag_color(tag: String) -> String {
  case tag {
    "coding" -> "text-tag-coding"
    "games" -> "text-tag-games"
    "life" -> "text-tag-life"
    _ -> "text-muted"
  }
}

pub fn post_tags(p: Post(msg)) -> List(String) {
  case dict.get(p.extras, "tags") {
    Ok(raw) ->
      raw
      |> string.split(",")
      |> list.map(string.trim)
      |> list.filter(fn(s) { s != "" })
    Error(Nil) -> []
  }
}

pub fn primary_tag(p: Post(msg)) -> String {
  case post_tags(p) {
    [first, ..] -> first
    [] -> "misc"
  }
}

/// Format a timestamp as "jul '26"
pub fn short_date(t: Timestamp) -> String {
  let #(date, _) = timestamp.to_calendar(t, calendar.utc_offset)
  let month = case date.month {
    calendar.January -> "jan"
    calendar.February -> "feb"
    calendar.March -> "mar"
    calendar.April -> "apr"
    calendar.May -> "may"
    calendar.June -> "jun"
    calendar.July -> "jul"
    calendar.August -> "aug"
    calendar.September -> "sep"
    calendar.October -> "oct"
    calendar.November -> "nov"
    calendar.December -> "dec"
  }
  let year = date.year % 100
  let year_str = case year < 10 {
    True -> "0" <> int.to_string(year)
    False -> int.to_string(year)
  }
  month <> " '" <> year_str
}
