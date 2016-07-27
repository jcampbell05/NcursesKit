import PackageDescription

let package = Package(
    name: "NcursesKit",
    dependencies: [
      .Package(url:"https://github.com/iachievedit/CNCURSES.git", majorVersion: 2)
    ]
)
