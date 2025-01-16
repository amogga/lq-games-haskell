# lq-games

[![Build Status](https://github.com/ahmedmogahed/lq-games-haskell/actions/workflows/haskell.yml/badge.svg?branch=main)](https://github.com/ahmedmogahed/lq-games-haskell/actions/workflows/haskell.yml?query=branch%3Amain) 
[![License](https://img.shields.io/badge/License-BSD--3--Clause-blue)](https://opensource.org/licenses/BSD-3-Clause)

This project is a demonstration of efficient backends for linear-quadratic games of autonomous driving multi-agent interactions. The implemented backends include:
- Iterative Linear-Quadratic Games ([iLQGames](https://doi.org/10.48550/arXiv.1909.04694))
- Augmented Lagrangian GAME-theoretic Solver ([ALGAMES](https://doi.org/10.48550/arXiv.1910.09713))
- Sequential Quadratic Programming ([SQP](https://doi.org/10.48550/arXiv.2203.16478))

#### Notes
The project requires `imagemagick` and `pkg-config` to be installed. On macOS, these libraries can be installed via brew as follows:
```shell
brew install imagemagick pkg-config
```