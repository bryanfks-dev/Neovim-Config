local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return { 
  s("vueinit", {
    t({
      "<script setup lang=\"ts\">",
      "",
      "</script>",
    }),
    t({
      "",
      "",
      "<template>",
      "\t",
    }),
    i(1),
    t({
      "",
      "</template>",
    }),
    t({
      "",
      "",
      "<style scoped></style>",
      "",
    }),
  }),
}

