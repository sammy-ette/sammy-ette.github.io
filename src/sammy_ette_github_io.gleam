import blog_config
import blogatto
import blogatto/error
import gleam/io

pub fn main() {
  case blogatto.build(blog_config.config()) {
    Ok(Nil) -> io.println("Website built!")
    Error(err) ->
      io.println_error("Website didn't build :( " <> error.describe_error(err))
  }
}
