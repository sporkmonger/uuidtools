require File.expand_path("../../spec_helper.rb", __FILE__)

def pending_if_root_required
  if @mac_address == nil
    output = `ifconfig -a 2>&1`
    if output =~ /inet/ &&
        output =~ /\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/ &&
        output =~ /Warning: cannot open/
      pending("Cannot get MAC address without root?")
    end
  end
end

# ===========================================================================
#
# Samples of ifconfig -a output
#
# ===========================================================================

#
# solaris
#
solaris_sample = <<EOF
lo0: flags=2001000849<UP,LOOPBACK,RUNNING,MULTICAST,IPv4,VIRTUAL> mtu 8232 index 1
        inet 127.0.0.1 netmask ff000000
igb1: flags=1000843<UP,BROADCAST,RUNNING,MULTICAST,IPv4> mtu 1500 index 2
        inet 10.51.0.18 netmask ffffff00 broadcast 10.51.0.255
        ether 0:21:28:fa:c6:65
igb2: flags=1000843<UP,BROADCAST,RUNNING,MULTICAST,IPv4> mtu 1500 index 3
        inet 10.99.0.12 netmask ffffff00 broadcast 10.99.0.255
        ether 0:21:28:fa:c6:66
EOF

solaris_mac = "00:21:28:fa:c6:65"

#
# windows
#
windows_sample = <<EOF
Windows IP Configuration

        Host Name . . . . . . . . . . . . : OFFICE
        Primary Dns Suffix  . . . . . . . :
        Node Type . . . . . . . . . . . . : Unknown
        IP Routing Enabled. . . . . . . . : No
        WINS Proxy Enabled. . . . . . . . : No

Ethernet adapter Local Area Connection:

        Connection-specific DNS Suffix  . :
        Description . . . . . . . . . . . : Realtek PCIe GBE Family Controller
        Physical Address. . . . . . . . . : E0-CB-4E-5D-BC-E9
        Dhcp Enabled. . . . . . . . . . . : No
        IP Address. . . . . . . . . . . . : 192.168.1.10
        Subnet Mask . . . . . . . . . . . : 255.255.255.0
        Default Gateway . . . . . . . . . : 192.168.1.1
        DNS Servers . . . . . . . . . . . : 192.168.1.1
                                            4.2.2.1
EOF

windows_mac = "e0:cb:4e:5d:bc:e9"

#
# linux
#
linux_sample = <<EOF
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.16.187.71  netmask 255.255.252.0  broadcast 10.16.187.255
        inet6 fe80::226:2dff:fef6:b94  prefixlen 64  scopeid 0x20<link>
        ether 00:26:2d:f6:0b:94  txqueuelen 1000  (Ethernet)
        RX packets 172074  bytes 82784684 (78.9 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 99075  bytes 23551085 (22.4 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        device interrupt 20  memory 0xf2600000-f2620000

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 0  (Local Loopback)
        RX packets 20  bytes 2148 (2.0 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 20  bytes 2148 (2.0 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
EOF

linux_mac = "00:26:2d:f6:0b:94"

#
# alternate linux
#
linux_sample_2 = <<EOF
eth0      Link encap:Ethernet  HWaddr 00:80:C8:F8:4A:51
          inet addr:192.168.99.35  Bcast:192.168.99.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:190312 errors:0 dropped:0 overruns:0 frame:0
          TX packets:86955 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:30701229 (29.2 Mb)  TX bytes:7878951 (7.5 Mb)
          Interrupt:9 Base address:0x5000

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:306 errors:0 dropped:0 overruns:0 frame:0
          TX packets:306 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:29504 (28.8 Kb)  TX bytes:29504 (28.8 Kb)
EOF

linux_mac_2 = "00:80:c8:f8:4a:51"

linux_ip_sample = <<EOF
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
    link/ether 00:26:2d:f6:0b:94 brd ff:ff:ff:ff:ff:ff
    inet 10.16.187.125/22 brd 10.16.187.255 scope global eth0
    inet6 fe80::226:2dff:fef6:b94/64 scope link
       valid_lft forever preferred_lft forever
3: wlan0: <BROADCAST,MULTICAST> mtu 1500 qdisc mq state DOWN qlen 1000
    link/ether 00:26:c6:c6:1a:b4 brd ff:ff:ff:ff:ff:ff
4: virbr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN
    link/ether 52:54:00:e3:cf:d3 brd ff:ff:ff:ff:ff:ff
    inet 192.168.122.1/24 brd 192.168.122.255 scope global virbr0
5: virbr0-nic: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast master virbr0 state DOWN qlen 500
    link/ether 52:54:00:e3:cf:d3 brd ff:ff:ff:ff:ff:ff
EOF

linux_ip_mac = "00:26:2d:f6:0b:94"

#
# freebsd
#
freebsd_sample = <<EOF
igb0: flags=8843<UP,BROADCAST,RUNNING,SIMPLEX,MULTICAST> metric 0 mtu 1500
        options=401bb<RXCSUM,TXCSUM,VLAN_MTU,VLAN_HWTAGGING,JUMBO_MTU,VLAN_HWCSUM,TSO4,VLAN_HWTSO>
        ether 00:25:90:2b:81:32
        inet6 fe80::225:90ff:fe2b:8132%igb0 prefixlen 64 scopeid 0x1
        nd6 options=29<PERFORMNUD,IFDISABLED,AUTO_LINKLOCAL>
        media: Ethernet autoselect (1000baseT <full-duplex>)
        status: active
igb1: flags=8843<UP,BROADCAST,RUNNING,SIMPLEX,MULTICAST> metric 0 mtu 1500
        options=401bb<RXCSUM,TXCSUM,VLAN_MTU,VLAN_HWTAGGING,JUMBO_MTU,VLAN_HWCSUM,TSO4,VLAN_HWTSO>
        ether 00:25:90:2b:81:32
        inet6 fe80::225:90ff:fe2b:8133%igb1 prefixlen 64 scopeid 0x2
        nd6 options=29<PERFORMNUD,IFDISABLED,AUTO_LINKLOCAL>
        media: Ethernet autoselect (1000baseT <full-duplex>)
EOF

freebsd_mac = "00:25:90:2b:81:32"

#
# openbsd
#
openbsd_sample = <<EOF
lo0: flags=8049<UP,LOOPBACK,RUNNING,MULTICAST> mtu 33200
        priority: 0
        groups: lo
        inet 127.0.0.1 netmask 0xff000000
        inet6 ::1 prefixlen 128
        inet6 fe80::1%lo0 prefixlen 64 scopeid 0x5
vr0: flags=8843<UP,BROADCAST,RUNNING,SIMPLEX,MULTICAST> mtu 1500
        lladdr 00:0d:b9:28:ab:44
        priority: 0
        media: Ethernet autoselect (100baseTX full-duplex)
        status: active
        inet 192.168.7.2 netmask 0xffffff00 broadcast 192.168.7.255
        inet6 fe80::20d:b9ff:fe28:ab44%vr0 prefixlen 64 scopeid 0x1
EOF

openbsd_mac = "00:0d:b9:28:ab:44"

#
# MacOS 10
#
macos_sample = <<EOF
lo0: flags=8049<UP,LOOPBACK,RUNNING,MULTICAST> mtu 16384
	options=3<RXCSUM,TXCSUM>
	inet6 fe80::1%lo0 prefixlen 64 scopeid 0x1
	inet 127.0.0.1 netmask 0xff000000
	inet6 ::1 prefixlen 128
gif0: flags=8010<POINTOPOINT,MULTICAST> mtu 1280
stf0: flags=0<> mtu 1280
en0: flags=8963<UP,BROADCAST,SMART,RUNNING,PROMISC,SIMPLEX,MULTICAST> mtu 1500
	options=27<RXCSUM,TXCSUM,VLAN_MTU,TSO4>
	ether 58:b0:35:a4:cd:0c
	inet6 fe80::5ab0:35ff:fea4:cd0c%en0 prefixlen 64 scopeid 0x4
	inet 192.168.142.136 netmask 0xfffffff0 broadcast 192.168.142.143
	media: autoselect (1000baseT <full-duplex,flow-control>)
	status: active
en1: flags=8823<UP,BROADCAST,SMART,SIMPLEX,MULTICAST> mtu 1500
	ether d8:30:62:51:dd:3d
	media: autoselect (<unknown type>)
	status: inactive
p2p0: flags=8802<BROADCAST,SIMPLEX,MULTICAST> mtu 2304
	ether 0a:30:62:51:dd:3d
	media: autoselect
	status: inactive
EOF

macos_mac = "58:b0:35:a4:cd:0c"

# Gather the samples and MAC addresses for simple access
samples = {
  :macos => macos_sample,
  :windows => windows_sample,
  :solaris => solaris_sample,
  :freebsd => freebsd_sample,
  :openbsd => openbsd_sample,
  :linux => linux_sample,
  :linux2 => linux_sample_2,
  :linuxip => linux_ip_sample
}

macs = {
  :macos => macos_mac,
  :windows => windows_mac,
  :solaris => solaris_mac,
  :freebsd => freebsd_mac,
  :openbsd => openbsd_mac,
  :linux => linux_mac,
  :linux2 => linux_mac_2,
  :linuxip => linux_ip_mac
}

# --------------------------------------------------------------------------
#
# TESTS
#
# --------------------------------------------------------------------------

describe UUIDTools::UUID, "when obtaining a MAC address" do
  before do
    @mac_address = UUIDTools::UUID.mac_address
  end

  it "should obtain a MAC address" do
    pending_if_root_required()
    expect(@mac_address).not_to be_nil
  end

  it "should cache the MAC address" do
    pending_if_root_required()
    expect(@mac_address.object_id).to eql(UUIDTools::UUID.mac_address.object_id)
  end
end

describe UUIDTools::UUID, "before obtaining a MAC address" do

  before do
    module UUIDTools
      class UUID
        remove_class_variable(:@@mac_address) if defined?(@@mac_address)
      end
    end
  end

  it "should parse windows MAC addresses" do
    # mock ifconfig() to return the windows sample
    allow(UUIDTools::UUID).to receive(:ifconfig) { samples[:windows] }
    mac = UUIDTools::UUID.mac_address
    expect(mac).to eql(macs[:windows])
  end

  it "should parse solaris MAC addresses" do
    allow(UUIDTools::UUID).to receive(:ifconfig) { samples[:solaris] }
    mac = UUIDTools::UUID.mac_address
    expect(mac).to eql(macs[:solaris])
  end

  it "should parse freebsd MAC addresses" do
    allow(UUIDTools::UUID).to receive(:ifconfig) { samples[:freebsd] }
    mac = UUIDTools::UUID.mac_address
    expect(mac).to eql(macs[:freebsd])
  end

  it "should parse openbsd MAC addresses" do
    allow(UUIDTools::UUID).to receive(:ifconfig) { samples[:openbsd] }
    mac = UUIDTools::UUID.mac_address
    expect(mac).to eql(macs[:openbsd])
  end

  it "should parse linux MAC addresses with ifconfig" do
    allow(UUIDTools::UUID).to receive(:ifconfig) { samples[:linux] }
    mac = UUIDTools::UUID.mac_address
    expect(mac).to eql(macs[:linux])
  end

  it "should parse a linux HWaddr address with ifconfig" do
    allow(UUIDTools::UUID).to receive(:ifconfig) { samples[:linux2] }
    mac = UUIDTools::UUID.mac_address
    expect(mac).to eql(macs[:linux2])
  end

  it "should parse macos MAC addresses with ifconfig" do
    allow(UUIDTools::UUID).to receive(:ifconfig) { samples[:macos] }
    mac = UUIDTools::UUID.mac_address
    expect(mac).to eql(macs[:macos])
  end

  it "should parse linux MAC addresses with ip" do
    allow(UUIDTools::UUID).to receive(:ifconfig) { samples[:linuxip] }
    mac = UUIDTools::UUID.mac_address
    expect(mac).to eql(macs[:linuxip])
  end

  it "should identify the default os classes" do
    module RbConfig
      CONFIG['target_os'] = nil
    end

    os_class = UUIDTools::UUID.os_class
    expect(os_class).to be_nil

    RbConfig::CONFIG['target_os'] = 'linux'
    os_class = UUIDTools::UUID.os_class
    expect(os_class).to be_nil

    RbConfig::CONFIG['target_os'] = 'darwin'
    os_class = UUIDTools::UUID.os_class
    expect(os_class).to be_nil
  end

  it "should identify the solaris os classes" do
    module RbConfig
      CONFIG['target_os'] = "solaris"
    end

    os_class = UUIDTools::UUID.os_class
    expect(os_class).to eql(:solaris)
  end

  it "should identify the BSD os classes" do
    module RbConfig
      CONFIG['target_os'] = "netbsd"
    end

    os_class = UUIDTools::UUID.os_class
    expect(os_class).to eql(:netbsd)

    RbConfig::CONFIG['target_os'] = "openbsd"
    os_class = UUIDTools::UUID.os_class
    expect(os_class).to eql(:openbsd)

  end

  it "should identify the Windows os classes" do
    module RbConfig
      CONFIG['target_os'] = "win"
    end
    os_class = UUIDTools::UUID.os_class
    expect(os_class).to eql(:windows)

    RbConfig::CONFIG['target_os'] = "w32"
    os_class = UUIDTools::UUID.os_class
    expect(os_class).to eql(:windows)

    RbConfig::CONFIG['target_os'] = "darwin"
    os_class = UUIDTools::UUID.os_class
    expect(os_class).to be_nil

  end

  it "should find the ifconfig program" do
    save_ifconfig_command = UUIDTools::UUID.ifconfig_command
    save_ifconfig_path = UUIDTools::UUID.ifconfig_path_default

    # this should always exist
    UUIDTools::UUID.ifconfig_command="sh"
    UUIDTools::UUID.ifconfig_path_default="notfound"
    ifconfig_path = UUIDTools::UUID.ifconfig_path
#    expect(ifconfig_path).to eql("/usr/bin/sh")

    # Test what happens if it does not
    UUIDTools::UUID.ifconfig_command="nosuchthing"
    UUIDTools::UUID.ifconfig_path_default="default"

    # ifconfig_path checks if the IFCONFIG_PATH command file exists
    allow(File).to receive(:exist?) { true }

    ifconfig_path = UUIDTools::UUID.ifconfig_path
#    expect(ifconfig_path).to eql("default")

    UUIDTools::UUID.ifconfig_command=save_ifconfig_command
    UUIDTools::UUID.ifconfig_path_default=save_ifconfig_path

  end

  it "should find the ip program" do
    save_ip_command = UUIDTools::UUID.ip_command
    save_ip_path = UUIDTools::UUID.ip_path_default

    # this should always exist
    UUIDTools::UUID.ip_command="sh"
    UUIDTools::UUID.ip_path_default="notfound"
    ip_path = UUIDTools::UUID.ip_path
#    expect(ip_path).to eql("/usr/bin/sh")

    # Test what happens if it does not
    UUIDTools::UUID.ip_command="nosuchthing"
    UUIDTools::UUID.ip_path_default="default"

    # ifconfig_path checks if the IP_PATH command file exists
    allow(File).to receive(:exist?) { true }

    ifconfig_path = UUIDTools::UUID.ip_path
#    expect(ifconfig_path).to eql("default")

    UUIDTools::UUID.ip_command=save_ip_command
    UUIDTools::UUID.ip_path_default=save_ip_path
  end

  it "should be able to parse windows ipconfig output" do
    mac = UUIDTools::UUID.first_mac samples[:windows]
    expect(mac).to eql(macs[:windows])
  end

  it "should be able to parse solaris ifconfig output" do
    mac = UUIDTools::UUID.first_mac samples[:solaris]
    expect(mac).to eql(macs[:solaris])
  end

  it "should be able to parse freebsd ifconfig output" do
    mac = UUIDTools::UUID.first_mac samples[:freebsd]
    expect(mac).to eql(macs[:freebsd])
  end

  it "should be able to parse openbsd ifconfig output" do
    mac = UUIDTools::UUID.first_mac samples[:openbsd]
    expect(mac).to eql(macs[:openbsd])
  end

  it "should be able to parse linux ifconfig output" do
    mac = UUIDTools::UUID.first_mac samples[:linux]
    expect(mac).to eql(macs[:linux])

    mac2 = UUIDTools::UUID.first_mac samples[:linux2]
    expect(mac2).to eql(macs[:linux2])
  end

  it "should be able to parse macos ifconfig output" do
    mac = UUIDTools::UUID.first_mac samples[:macos]
    expect(mac).to eql(macs[:macos])
  end

  it "should be able to parse ip addr output" do
    mac = UUIDTools::UUID.first_mac samples[:linuxip]
    expect(mac).to eql(macs[:linuxip])
  end
end
