load("//engine/build:isaac.bzl", "isaac_app", "isaac_jupyter_app")

isaac_app(
    name = "joystick_sim",
    data = [
        "//packages/navigation/apps:differential_base_commander_subgraph",
    ],
    modules = ["navigation", "viewers"]
)