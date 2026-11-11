#[path = "a.rs"]
mod a;

fn main() {
    println!("{}", a::greet("merge-guard"));
}
