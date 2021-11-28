<div id="top"></div>

<!-- PROJECT SHIELDS -->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <h1 align="center">Spellbook</h1>
  <p align="center">
    D&D inspired Powershell helper to register defined commands as simple functions with parameter completers. Every Wizard should have one.
    <br />
    <a href="https://github.com/Ark667/Spellbook"><strong>Explore the docs »</strong></a>
    <br />    
    <a href="https://github.com/Ark667/Spellbook/issues">Report Bug</a>
    ·
    <a href="https://github.com/Ark667/Spellbook/issues">Request Feature</a>
  </p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li><a href="#getting-started">Getting Started</a></li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#tips">Tips</a></li>
    <!-- <li><a href="#roadmap">Roadmap</a></li> -->
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <!-- <li><a href="#acknowledgments">Acknowledgments</a></li> -->
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project

<!-- [![Product Name Screen Shot][product-screenshot]](https://example.com) -->

This project was intended to boost Powershell productivity by making day to day tasks faster and easier. The basic idea is define Powershell
commands with its parameter and default value definitions in a file, and make a process register function aliases over them with parameter
completers. This makes the command call crazy easy with Tab autocomplete magic.

This idea comes specially useful with Docker containers, avoiding to install nothing but Docker, and run complex commands without extra prerequisites.
Some extra features where added after, like extended history, index, and command help.

<p align="right">(<a href="#top">back to top</a>)</p>

### Built With

* [Powershell](https://docs.microsoft.com/powershell/)

Powershell execution policy must allow script execution. 
<!-- https://adamtheautomator.com/how-to-sign-powershell-script/ -->
 
```pws
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

* [powershell-yaml](https://github.com/cloudbase/powershell-yaml)

Spell definitions are YAML based, but Powershell does not have a built in ConvertFrom-Yaml. Installing this module
makes the trick for now.

```pws
Install-Module powershell-yaml
```

<p align="right">(<a href="#top">back to top</a>)</p>


<!-- GETTING STARTED -->
## Getting Started

1. Clone the repo.

   ```pws
   git clone https://github.com/Ark667/Spellbook.git
   ```

2. Execute Spellbook register.

   ```pws
   .\Spellbook\src\Spellbook.ps1
   ```

3. Execute index command, just type "Spell" and Tab through options.

   ```pws
   Spellbook-Index
   ```

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- USAGE EXAMPLES -->
## Usage

Configure in $profile the invocation of this  script
The global commands you can search for spells, view its documentation or update the current definitions.

The index shows available spells registered. Filter argument apply over result on Tags and School.

```pws
Spellbook-Index [filter]
```

Help shows command documentation.

```pws
Spellbook-Help [spell]
```

History shows commands execution log with its full info.

```pws
Spellbook-History
```

Update registers the current definitions.

```pws
Spellbook-Update
```

Now you can execute some spells.

This example execute de AWS Cli through official Docker container. This spell (Aws-Cli) also has 
an alias to make it work like AWS Cli where installed in your machine.

```pws
aws
```

This simple spell will create a MySql container with mapped volume, exposed port and default root password, everything displayed on output.

```pws
Create-MySql
```

Just enjoy!

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- USAGE EXAMPLES -->
## Tips

Spellbook load can be added on Powershell terminal startup adding a call to Spellbook.ps1 on profile file. Just edit
the file with this call.

```pws
notepad.exe $profile
```

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

Show me your spells!

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/I2I16OYC5)

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- CONTACT -->
## Contact

Aingeru Medrano - [@AingeruBlack](https://twitter.com/AingeruBlack) <!-- - email@email_client.com -->

Project Link: [https://github.com/Ark667/Spellbook](https://github.com/Ark667/Spellbook)

<p align="right">(<a href="#top">back to top</a>)</p>

## Acknowledgments

[http://patorjk.com](http://patorjk.com/software/taag/#p=display&c=bash&f=Delta%20Corps%20Priest%201&t=Spellbook)

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/Ark667/Spellbook.svg?style=for-the-badge
[contributors-url]: https://github.com/Ark667/Spellbook/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Ark667/Spellbook.svg?style=for-the-badge
[forks-url]: https://github.com/Ark667/Spellbook/network/members
[stars-shield]: https://img.shields.io/github/stars/Ark667/Spellbook.svg?style=for-the-badge
[stars-url]: https://github.com/Ark667/Spellbook/stargazers
[issues-shield]: https://img.shields.io/github/issues/Ark667/Spellbook.svg?style=for-the-badge
[issues-url]: https://github.com/Ark667/Spellbook/issues
[license-shield]: https://img.shields.io/github/license/Ark667/Spellbook.svg?style=for-the-badge
[license-url]: https://github.com/Ark667/Spellbook/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/aingeru/
[product-screenshot]: images/screenshot.png
