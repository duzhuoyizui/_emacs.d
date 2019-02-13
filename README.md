# Emacs 26.1 on macOS

+ `f3`: 打开 eshell
+ `f4`: 插入当前时间
+ `f6`: 显示当前文件路径
+ `f9`: 进入 ace 模式

## FAQ

1. 正常安装时有依赖问题，`helm` 和 `magit` 导致的，这两个插件需要手动 `package-install` 安装
2. 推荐使用国外的源，更新一些，但是在不能 FQ 的情况下，在 `lisp/init-elpa.el` 中打开 `163` 的或者清华大学的镜像
