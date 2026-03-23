///|
/// Entry point for the CLI or runnable program in this template.
/// Keep main focused; move logic into the library package.
/// Run with `moon run cmd/main` from the project root.
fn main {
  let (_, report) = @moonseo.generate_demo(
    "",
    "MoonSEO", "seo content audit", "content teams", "Runs in the browser\nExports static HTML\nShows evidence anchors",
  )
  println(report.summary_text)
}
