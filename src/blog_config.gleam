import blogatto/config
import blogatto/config/feed/atom
import blogatto/config/feed/rss
import blogatto/config/post as post_cfg
import blogatto/config/post/code
import blogatto/config/robots
import blogatto/config/sitemap
import gleam/dict
import gleam/int
import gleam/option
import gleam/time/timestamp
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import pages/about
import pages/blog
import pages/index
import pages/post
import pages/projects
import pages/uses

const site_url = "https://sammyette.party"

pub fn config() -> config.Config(Nil) {
  let post_config =
    post_cfg.default()
    |> post_cfg.path("./blog")
    |> post_cfg.route_prefix("blog")
    |> post_cfg.template(post.template)
    |> post_cfg.a(fn(_attrs, href, _title, children) {
      html.a([attribute.href(href)], children)
    })
    |> post_cfg.p(fn(_attrs, children) {
      html.p(
        [
          attribute.class(
            "font-sans text-base leading-[1.85] text-body m-0 mb-[22px]",
          ),
        ],
        children,
      )
    })
    |> post_cfg.blockquote(fn(_attrs, children) {
      html.blockquote(
        [
          attribute.class(
            "mb-[22px] pl-5 border-l-2 border-border-strong italic text-muted-2",
          ),
        ],
        children,
      )
    })
    |> post_cfg.code(fn(_attrs, _lang, children) {
      html.code(
        [
          attribute.class(
            "font-mono text-[0.9em] text-cream bg-surface-2 rounded px-1.5 py-0.5",
          ),
        ],
        children,
      )
    })
    |> post_cfg.pre(fn(_attrs, children) {
      html.pre(
        [
          attribute.class(
            "bg-ink-3 border border-border rounded px-[22px] py-5 overflow-x-auto mb-[22px]",
          ),
        ],
        children,
      )
    })
    |> post_cfg.h1(heading(html.h1, "text-3xl"))
    |> post_cfg.h2(heading(html.h2, "text-2xl"))
    |> post_cfg.h3(heading(html.h3, "text-xl"))
    |> post_cfg.h4(heading(html.h4, "text-lg"))
    |> post_cfg.h5(heading(html.h5, "text-base"))
    |> post_cfg.h6(heading(html.h6, "text-base"))
    |> post_cfg.ul(fn(children) {
      html.ul(
        [
          attribute.class(
            "list-disc pl-5 mb-[22px] flex flex-col gap-1.5 font-sans text-base leading-[1.85] text-body",
          ),
        ],
        children,
      )
    })
    |> post_cfg.ol(fn(start, children) {
      let extra = case start {
        option.Some(n) -> [attribute.attribute("start", int.to_string(n))]
        option.None -> []
      }
      html.ol(
        [
          attribute.class(
            "list-decimal pl-5 mb-[22px] flex flex-col gap-1.5 font-sans text-base leading-[1.85] text-body",
          ),
          ..extra
        ],
        children,
      )
    })
    |> post_cfg.li(fn(children) { html.li([], children) })
    |> post_cfg.strong(fn(children) {
      html.strong([attribute.class("text-cream font-semibold")], children)
    })
    |> post_cfg.em(fn(children) {
      html.em([attribute.class("italic")], children)
    })
    |> post_cfg.img(fn(_attrs, src, alt, _title) {
      html.img([
        attribute.src(src),
        attribute.alt(alt),
        attribute.class("max-w-full rounded border border-border my-2"),
      ])
    })
    |> post_cfg.footnote(fn(number, children) {
      let num = int.to_string(number)
      html.sup([attribute.class("font-mono text-[11px] text-tag-coding")], [
        html.a(
          [attribute.id("fnref-" <> num), attribute.href("#fn-" <> num)],
          children,
        ),
      ])
    })
    |> post_cfg.syntax_highlighting(
      code.default()
      |> code.keyword(tok("oklch(0.74 0.10 288)"))
      |> code.builtin(tok("oklch(0.74 0.10 288)"))
      |> code.string(tok("oklch(0.82 0.05 75)"))
      |> code.regex(tok("oklch(0.82 0.05 75)"))
      |> code.number(tok("oklch(0.62 0.17 258)"))
      |> code.constant(tok("oklch(0.62 0.17 258)"))
      |> code.type_(tok("oklch(0.62 0.17 258)"))
      |> code.module(tok("oklch(0.62 0.17 258)"))
      |> code.function(tok("oklch(0.62 0.14 288)"))
      |> code.tag(tok("oklch(0.62 0.14 288)"))
      |> code.selector(tok("oklch(0.62 0.14 288)"))
      |> code.attribute(tok("oklch(0.68 0.03 85)"))
      |> code.property(tok("oklch(0.68 0.03 85)"))
      |> code.operator(tok("oklch(0.68 0.03 85)"))
      |> code.punctuation(tok("oklch(0.68 0.03 85)"))
      |> code.variable(tok("oklch(0.90 0.02 85)"))
      |> code.comment(fn(value) {
        html.span(
          [
            attribute.style("color", "oklch(0.68 0.03 85)"),
            attribute.style("font-style", "italic"),
          ],
          [element.text(value)],
        )
      }),
    )

  let rss_feed =
    rss.new("sammyette's place", site_url, "sammyette's blog")
    |> rss.language("en-us")
    |> rss.generator("Blogatto")

  let atom_feed =
    atom.new(
      id: site_url <> "/",
      title: atom.PlainText("sammyette's place"),
      updated: timestamp.system_time(),
    )
    |> atom.subtitle("sammyette's blog")
    |> atom.link(atom.Link(
      href: site_url <> "/atom.xml",
      rel: option.Some("self"),
      content_type: option.Some("application/atom+xml"),
      hreflang: option.None,
      title: option.None,
      length: option.None,
    ))
    |> atom.generator(atom.Generator(
      uri: option.Some("https://github.com/veeso/blogatto"),
      version: option.None,
    ))

  let sitemap_config = sitemap.new("/sitemap.xml")

  let robots_config =
    robots.RobotsConfig(sitemap_url: site_url <> "/sitemap.xml", robots: [
      robots.Robot(
        user_agent: "*",
        allowed_routes: ["/"],
        disallowed_routes: [],
      ),
    ])

  config.new(site_url)
  |> config.output_dir("./public")
  |> config.static_dir("./static")
  |> config.post(post_config)
  |> config.route("/", index.page)
  |> config.route("/blog", blog.page)
  |> config.route("/projects", projects.page)
  |> config.route("/about", about.page)
  |> config.route("/uses", uses.page)
  |> config.rss_feed(rss_feed)
  |> config.atom_feed(atom_feed)
  |> config.sitemap(sitemap_config)
  |> config.robots(robots_config)
}

fn heading(
  tag: fn(List(attribute.Attribute(Nil)), List(Element(Nil))) -> Element(Nil),
  size_class: String,
) -> fn(dict.Dict(String, String), String, List(Element(Nil))) -> Element(Nil) {
  fn(_attrs, id, children) {
    tag(
      [
        attribute.id(id),
        attribute.class("font-serif text-cream mt-9 mb-3"),
        attribute.class(size_class),
      ],
      children,
    )
  }
}

fn tok(color: String) -> fn(String) -> Element(Nil) {
  fn(value) {
    html.span([attribute.style("color", color)], [element.text(value)])
  }
}
