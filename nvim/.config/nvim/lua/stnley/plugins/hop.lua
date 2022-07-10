local has_hop, local_hop= pcall(require, "hop")

if not has_hop then
  return
end

local_hop.setup {
  quit_key = '<SPC>',
  jump_on_sole_occurrence = false,
}

