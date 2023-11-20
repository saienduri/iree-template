iree_cc_binary(
  NAME
    hello_world
  SRCS
    "hello_world.c"
  DEPS
    iree::runtime
)
