# Julia Tutorial

We will be trying out the Julia language, and getting some code to run, so everyone needs a working Julia installation!

## Installation

You will need to download the Julia language from here:

I installed version 1.9.4. Once I run it, it opens a terminal window (for those with Mac, and I presume Linux as well).

```bash
carlosar@macpin-3 in ~
○ → /Applications/Julia-1.9.app/Contents/Resources/julia/bin/julia ; exit;
               _
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.9.4 (2023-11-14)
 _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
|__/                   |

```

### IDE

Some options for a *python* or *matlab* like IDE:

- Install VSCode
  - https://github.com/julia-vscode/julia-vscode#installing-juliavs-codevs-code-julia-extension
  - This is what I ended up doing and it was a bit convoluted:
  - I needed to set the `julia.executablePath` for the Julia installation: `/Applications/Julia-1.9.app/Contents/Resources/julia/bin/julia` which means it did not find the default installation
- https://junolab.org/
  - This is the older recommended version, but it has halted development :(
  - I did not try to use this
- Jupyter
  - I have Anaconda installed and use it for my Python/Jupyter/iPython projects from time to time, but I opted to allow Julia to install its own Miniconda and jupyter
  - https://github.com/JuliaLang/IJulia.jl#quick-start

### Package manager

A little bit about package managers. I've been using Anaconda for a long time and it helps me with sharing packages, instead of using `pip` the package manager that Python ships with.

When trying out Julia, I've been pretty happy with its `Pkg` manager so far. For the tutorial, we will be using at least the `Plots` package. 

#### How to install packages

Once you get Julia installed, and have the terminal window as below, you can type `[` and you will switch from having the `julia` prompt to the `@v1.9 pkg>`.



```bash
(py-python:) 2023-11-28 05:39:12   carlosar@macpin-3 in ~
○ → julia 
               _
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.9.4 (2023-11-14)
 _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
|__/                   |

julia> 

# I typed `[` then I got the prompt below

(@v1.9) pkg> status
Status `~/.julia/environments/v1.9/Project.toml`
  [7073ff75] IJulia v1.24.2
  [91a5bcdd] Plots v1.39.0

(@v1.9) pkg> 

```

Then, if you type `status` or `st` you will see the installed packages, namely in our case, `IJulia` and `Plots`. These two you need to install, when in the `pkg` mode:

```bash
(@v1.9) pkg> add IJulia Plots
```

And you are done and ready to go!

## Coming from Python and Matlab (or others)

They have a great list of changes for those coming from other languages:

- https://docs.julialang.org/en/v1/manual/noteworthy-differences/#Noteworthy-differences-from-MATLAB
- https://docs.julialang.org/en/v1/manual/noteworthy-differences/#Noteworthy-differences-from-Python

We will be exploring some of these changes!

### Matlab

Since I do not have a working installation of Matlab, maybe some of you can test this! I asked chat GPT to convert the Julia code into Matlab, which I think will be very straightforward:

---

<u>ChatGPT Prompt:</u>

convert this code from julia to matlab 

```julia
using Plots
n_points = 101;
x = range(-2*pi,2*pi, n_points);
# y = [sin(i) for i in x]
y = sin.(x);
plot(x,y)
```

<u>Response:</u>

Certainly! Here's the equivalent MATLAB code using the `plot` function from the `Plots` package:

```matlab
n_points = 101;

x = linspace(-2*pi, 2*pi, n_points);
y = sin(x);

plot(x, y)
title('Plot of sin(x)')
xlabel('x')
ylabel('y')
```

Make sure you have the `Plots` package installed in your MATLAB environment. If it's not installed, you can install it using the following command:

```
matlabCopy code
installPlots
```

This code creates a plot of the sine function over the specified range using the `plot` function from the `Plots` package in MATLAB.

---

