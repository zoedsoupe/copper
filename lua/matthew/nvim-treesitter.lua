local present, ts_config = pcall(require, "nvim-treesitter.configs")
if not present then
   return
end

ts_config.setup {
   ensure_installed = {
    "bash",
    "bibtex",
    "c",
    "clojure",
    "commonlisp",
    "css",
    "dockerfile",
    "elixir",
    "elm",
    "erlang",
    "fish",
    "haskell",
    "html",
    "javascript",
    "json",
    "latex",
    "lua",
    "nix",
    "ocaml",
    "python",
    "rust",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "yaml"
   },
   highlight = {
      enable = true,
      use_languagetree = true,
   },
}
