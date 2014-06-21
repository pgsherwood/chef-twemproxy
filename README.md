# twemproxy-cookbook

This cookbook installs [twemproxy](https://github.com/twitter/twemproxy) to act as a proxy for 2 redis server instances.

## Supported Platforms

Ubuntu 12.04

## Requirements

### APT Packages
- redis-server

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['twemproxy']['version']</tt></td>
    <td>String</td>
    <td>The version of twemproxy to install</td>
    <td><tt>0.3.0</tt></td>
  </tr>
  <tr>
    <td><tt>['twemproxy']['url']</tt></td>
    <td>String</td>
    <td>The url for downloading the tarfile release of twemproxy</td>
    <td><tt>https://twemproxy.googlecode.com/files</tt></td>
  </tr>
  <tr>
    <td><tt>['twemproxy']['redis_server1_port']</tt></td>
    <td>String</td>
    <td>The port number for the first redis server</td>
    <td><tt>6379</tt></td>
  </tr>
  <tr>
    <td><tt>['twemproxy']['redis_server2_port']</tt></td>
    <td>String</td>
    <td>The port number for the second redis server</td>
    <td><tt>6380</tt></td>
  </tr>
  <tr>
    <td><tt>['twemproxy']['twemproxy_port']</tt></td>
    <td>String</td>
    <td>The port number for twemproxy</td>
    <td><tt>23559</tt></td>
  </tr>
</table>

## Usage

### twemproxy::default

Include `twemproxy` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[twemproxy::default]"
  ]
}
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License and Authors

Author:: Greg Sherwood (<pgscode@gmail.com>)
