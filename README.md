<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Thanks again! Now go create something AMAZING! :D
***
***
***
*** To avoid retyping too much info. Do a search and replace for the following:
*** anthr76, tooling, anthonyrabbito, hello@anthonyrabbito.com, Personal DevOps Tooling, project_description
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![ASL License][license-shield]][license-url]



<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/anthr76/tooling">
    <img src="https://pixy.org/src/16/160904.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Tooling</h3>

  <p align="center">
    Personal portable developer operations container. PPDOC
    <br />
    <a href="https://github.com/anthr76/tooling/docs"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/anthr76/tooling">View Demo</a>
    ·
    <a href="https://github.com/anthr76/tooling/issues">Report Bug</a>
    ·
    <a href="https://github.com/anthr76/tooling/issues">Request Feature</a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

[![asciicast](https://asciinema.org/a/LOSmlIAVU6J1iHXWbDCGKaFRo.svg)](https://asciinema.org/a/LOSmlIAVU6J1iHXWbDCGKaFRo)

<script id="asciicast-LOSmlIAVU6J1iHXWbDCGKaFRo" src="https://asciinema.org/a/LOSmlIAVU6J1iHXWbDCGKaFRo.js" async></script>



### Built With

* [Podman](https://github.com/containers/podman)
* [Buildah](https://github.com/containers/buildah)
* [Toolbox](https://github.com/containers/toolbox)



<!-- GETTING STARTED -->
## Getting Started

> TODO

### Prerequisites

You'll need toolbox, and podman installed
* toolbox
  ```sh
  sudo dnf install toolbox
  ```

### Installation

1. Clone or fork the repo
   ```sh
   git clone https://github.com/anthr76/tooling.git
   ```
2. Make your desired ansible changes or provision the *shim* image how you like
   ```sh
   TODO
   ```



<!-- USAGE EXAMPLES -->
## Usage

This repo is intended to store my personal tooling for toolbox in VCS. My optimal DevOps environment uses a OpenSUSE [Tumbleweed](https://registry.opensuse.org/cgi-bin/cooverview)container packaged with DNF instead of Zypper. I choose to use Tumbleweed since it's rolling and I package my applications I use on a daily basis on [OBS](https://build.opensuse.org/package/show/home:anthr76:kubernetes/). The tumbleweed DNF container I have built here should be submitted back to Toolbox once it's cleaned up. My shim container then adds my ansible configured opions on a timer to ensure it's always up to date.

_For more examples, please refer to the [Upstream Documentation](https://github.com/containers/toolbox)_



<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/anthr76/tooling/issues) for a list of proposed features (and known issues).



<!-- CONTRIBUTING -->
## Contributing

Although this is my personal project that others likely won't find useful I'm always open to learning new things and seeing how others interpret things. 

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request



<!-- LICENSE -->
## License

Distributed under the ASL 2.0 License. See `LICENSE` for more information.



<!-- CONTACT -->
## Contact

Anthony Rabbito - [@anthonyrabbito](https://twitter.com/anthonyrabbito) - hello@anthonyrabbito.com

[https://github.com/anthr76/tooling](https://github.com/anthr76/tooling)



<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements

* [Containers Devs](https://github.com/containers?q=&type=&language=)





<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/anthr76/tooling.svg?style=for-the-badge
[contributors-url]: https://github.com/anthr76/tooling/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/anthr76/tooling.svg?style=for-the-badge
[forks-url]: https://github.com/anthr76/tooling/network/members
[stars-shield]: https://img.shields.io/github/stars/anthr76/tooling.svg?style=for-the-badge
[stars-url]: https://github.com/anthr76/tooling/stargazers
[issues-shield]: https://img.shields.io/github/issues/anthr76/tooling.svg?style=for-the-badge
[issues-url]: https://github.com/anthr76/tooling/issues
[license-shield]: https://img.shields.io/github/license/anthr76/tooling.svg?style=for-the-badge
[license-url]: https://github.com/anthr76/tooling/blob/master/LICENSE