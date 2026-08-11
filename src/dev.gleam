import blog_config
import blogatto/dev
import blogatto/error
import gleam/io
import shellout

pub fn main() {
  let result =
    blog_config.config()
    |> dev.new()
    |> dev.before_build(fn() {
      case
        shellout.command(
          run: "bun",
          with: ["run", "build:css"],
          in: ".",
          opt: [],
        )
      {
        Ok(_) -> Ok(Nil)
        Error(#(_, message)) -> Error(message)
      }
    })
    |> dev.port(1337)
    |> dev.start()

  case result {
    Ok(Nil) -> io.println("Dev server stopped.")
    Error(err) ->
      io.println_error("Dev server error: " <> error.describe_error(err))
  }
}
