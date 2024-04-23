local ls = require 'luasnip'

local fmta = require('luasnip.extras.fmt').fmta
local rep = require('luasnip.extras').rep

local s = ls.snippet
local d = ls.dynamic_node
local i = ls.insert_node
ls.add_snippets('go', {
  s(
    'efi',
    fmta(
      [[
<val>, <err> := <f>(<args>)
if <err_same> != nil {
	return <result>
}
<finish>
]],
      {
        val = i(1),
        err = i(2, 'err'),
        f = i(3),
        args = i(4),
        err_same = rep(2),
        result = d(5, go_return_values, { 2, 3 }),
        finish = i(0),
      }
    )
  ),
  s('ie', fmta('if err != nil {\n\treturn <err>\n}', { err = i(1, 'err') })),
})
