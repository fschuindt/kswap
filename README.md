# `kswap`
Helps with changing the current Kubernetes cluster of `kubectl` by managing `~/.kube` config files.

It's really similar with [`kubectx`](https://github.com/ahmetb/kubectx) (And I still use it), but it's better suited for when working with config files downloaded from the Digital Ocean dashboard.

## Installation

Just clone it and add it to your bin path:
```
$ git clone git@github.com:fschuindt/kswap.git && cd kswap
$ sudo chmod +x kswap.sh && sudo cp kswap.sh /usr/bin/kswap
```

Check if it's working:
```
$ kswap v
v0.0.1a
```

## Usage
Add all your DO K8s config files to the `~/.kube` path as `.yaml` files (`.yml` won't work). Make sure you don't have anything important at the `~/.kube/config` file, we'll use this file to store your current config, so anything residing on it will be lost.

```
$ kswap
```
Will list all your available configs and point out the current one. (If there's one).

```
$ kswap config-name
```
Changes the current K8s config to the chosen one.

```
$ kswap v
```
Displays kswap version.

```
$ kswap h
```
Displays a usage guide.

## License
The software is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

