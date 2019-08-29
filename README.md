# Emacs 26 on macOS/Ubuntu

Document: <http://wiki.zhangjiee.com/programming/code-env-emacs.html>

## Python

    pip install 'python-language-server[all]'


存在问题：

- 无法使用 flycheck 无法选择 `flake8`，[issue](https://github.com/emacs-lsp/lsp-mode/issues/746)

## CSS/LessCSS/SASS/SCSS

	npm install -g vscode-css-languageserver-bin

似乎不太需要，CSS 本来就很简单。

## JS

	npm i -g typescript-language-server; npm i -g typescript

太卡了，不能用。

## Go

    go get golang.org/x/tools/gopls
