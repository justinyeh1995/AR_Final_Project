//
//  CybORG_ARVizTests.swift
//  CybORG-ARVizTests
//
//  Created by Justin Yeh on 3/31/24.
//

import XCTest
@testable import CybORG_ARViz

let testJSON = """
{
    "Blue": {
        "link_diagram": {
            "directed": false,
            "multigraph": false,
            "graph": {},
            "nodes": [
                {
                    "id": "Defender"
                },
                {
                    "id": "Enterprise0"
                },
                {
                    "id": "Enterprise1"
                },
                {
                    "id": "Enterprise2"
                },
                {
                    "id": "Op_Host0"
                },
                {
                    "id": "Op_Host1"
                },
                {
                    "id": "Op_Host2"
                },
                {
                    "id": "Op_Server0"
                },
                {
                    "id": "User0"
                },
                {
                    "id": "User1"
                },
                {
                    "id": "User2"
                },
                {
                    "id": "User3"
                },
                {
                    "id": "User4"
                },
                {
                    "id": "Enterprise_router"
                },
                {
                    "id": "Operational_router"
                },
                {
                    "id": "User_router"
                }
            ],
            "links": [
                {
                    "source": "Defender",
                    "target": "Enterprise_router"
                },
                {
                    "source": "Enterprise0",
                    "target": "Enterprise_router"
                },
                {
                    "source": "Enterprise1",
                    "target": "Enterprise_router"
                },
                {
                    "source": "Enterprise2",
                    "target": "Enterprise_router"
                },
                {
                    "source": "Op_Host0",
                    "target": "Operational_router"
                },
                {
                    "source": "Op_Host1",
                    "target": "Operational_router"
                },
                {
                    "source": "Op_Host2",
                    "target": "Operational_router"
                },
                {
                    "source": "Op_Server0",
                    "target": "Operational_router"
                },
                {
                    "source": "User0",
                    "target": "User_router"
                },
                {
                    "source": "User1",
                    "target": "User_router"
                },
                {
                    "source": "User2",
                    "target": "User_router"
                },
                {
                    "source": "User3",
                    "target": "User_router"
                },
                {
                    "source": "User4",
                    "target": "User_router"
                },
                {
                    "source": "Enterprise_router",
                    "target": "Operational_router"
                },
                {
                    "source": "Enterprise_router",
                    "target": "User_router"
                },
                {
                    "source": "Operational_router",
                    "target": "User_router"
                }
            ]
        },
        "node_colors": [
            "green",
            "green",
            "green",
            "green",
            "green",
            "green",
            "green",
            "green",
            "red",
            "green",
            "green",
            "green",
            "green",
            "green",
            "green",
            "green"
        ],
        "node_borders": [
            {
                "width": 0,
                "color": "white"
            },
            {
                "width": 0,
                "color": "white"
            },
            {
                "width": 0,
                "color": "white"
            },
            {
                "width": 0,
                "color": "white"
            },
            {
                "width": 0,
                "color": "white"
            },
            {
                "width": 0,
                "color": "white"
            },
            {
                "width": 0,
                "color": "white"
            },
            {
                "width": 0,
                "color": "white"
            },
            {
                "width": 0,
                "color": "white"
            },
            {
                "width": 0,
                "color": "white"
            },
            {
                "width": 0,
                "color": "white"
            },
            {
                "width": 0,
                "color": "white"
            },
            {
                "width": 0,
                "color": "white"
            },
            {
                "width": 0,
                "color": "white"
            },
            {
                "width": 0,
                "color": "white"
            },
            {
                "width": 0,
                "color": "white"
            }
        ],
        "compromised_hosts": [
            "User0"
        ],
        "host_info": [
            "System info:<br>LINUX UBUNTU (x64)<br><br>Processes info:<br>- init (PID: 1, User: root, )<br>- systemd-journald (PID: 389, User: root, )<br>- systemd-udevd (PID: 407, User: root, )<br>- lvmetad (PID: 409, User: root, )<br>- systemd-timesyncd (PID: 560, User: systemd+, )<br>- accounts-daemon (PID: 790, User: root, )<br>- atd (PID: 802, User: daemon, )<br>- bash (PID: 803, User: velocir+, )<br>- rsyslogd (PID: 807, User: syslog, )<br>- acpid (PID: 824, User: root, )<br>- snapd (PID: 825, User: root, )<br>- dbus-daemon (PID: 827, User: message+, )<br>- velociraptor.bin (PID: 832, User: velocir+, )<br>- cron (PID: 844, User: root, )<br>- systemd-logind (PID: 847, User: root, )<br>- python3 (PID: 852, User: root, )<br>- lxcfs (PID: 853, User: root, )<br>- polkitd (PID: 863, User: root, )<br>- python3 (PID: 867, User: root, )<br>- agetty (PID: 875, User: root, )<br>- agetty (PID: 884, User: root, )<br>- python3 (PID: 1370, User: root, )<br>- systemd-hostnamed (PID: 1432, User: root, )<br>- sshd (PID: 2288, User: root, )<br>- sshd (PID: 879, User: root, Port: 22)<br>- systemd-resolved (PID: 656, User: systemd+, Port: 53, Port: 53)<br>- systemd-networkd (PID: 634, User: systemd+, Port: 68)<br>- VelociraptorServer (PID: 2289, User: ubuntu, )<br>- VelociraptorClient (PID: 2298, User: ubuntu, )<br>",
            "System info:<br>LINUX UBUNTU (x64)<br><br>Processes info:<br>- sshd (PID: 1091, User: root, Port: 22)<br>- VelociraptorClient (PID: 1100, User: ubuntu, )<br>",
            "System info:<br>WINDOWS WINDOWS_SVR_2008 (x64)<br><br>Processes info:<br>- sshd.exe (PID: 3368, User: sshd_server, Port: 22)<br>- svchost.exe (PID: 832, User: SYSTEM, Port: 135)<br>- svchost.exe (PID: 4400, User: SYSTEM, Port: 3389)<br>- smss.exe (PID: 4, User: SYSTEM, Port: 445, Port: 139)<br>- tomcat8.exe (PID: 3404, User: NetworkService, Port: 80, Port: 443)<br>- VelociraptorClient (PID: 4405, User: SYSTEM, )<br>",
            "System info:<br>WINDOWS WINDOWS_SVR_2008 (x64)<br><br>Processes info:<br>- sshd.exe (PID: 3368, User: sshd_server, Port: 22)<br>- svchost.exe (PID: 832, User: SYSTEM, Port: 135)<br>- svchost.exe (PID: 4400, User: SYSTEM, Port: 3389)<br>- smss.exe (PID: 4, User: SYSTEM, Port: 445, Port: 139)<br>- tomcat8.exe (PID: 3404, User: NetworkService, Port: 80, Port: 443)<br>- VelociraptorClient (PID: 4409, User: SYSTEM, )<br>",
            "System info:<br>LINUX UBUNTU (x64)<br><br>Processes info:<br>- sshd (PID: 1091, User: root, Port: 22)<br>- VelociraptorClient (PID: 1099, User: ubuntu, )<br>- green_session (PID: 1108, User: GreenAgent, )<br>",
            "System info:<br>LINUX UBUNTU (x64)<br><br>Processes info:<br>- sshd (PID: 1091, User: root, Port: 22)<br>- VelociraptorClient (PID: 1093, User: ubuntu, )<br>- green_session (PID: 1101, User: GreenAgent, )<br>",
            "System info:<br>LINUX UBUNTU (x64)<br><br>Processes info:<br>- sshd (PID: 1091, User: root, Port: 22)<br>- VelociraptorClient (PID: 1098, User: ubuntu, )<br>- green_session (PID: 1104, User: GreenAgent, )<br>",
            "System info:<br>LINUX UBUNTU (x64)<br><br>Processes info:<br>- sshd (PID: 1091, User: root, Port: 22)<br>- OTService (PID: 1043, User: root, )<br>- VelociraptorClient (PID: 1099, User: ubuntu, )<br>",
            "System info:<br>WINDOWS WINDOWS_SVR_2008 (x64)<br><br>Processes info:<br>- sshd.exe (PID: 3368, User: sshd_server, Port: 22)<br>- femitter.exe (PID: 3344, User: SYSTEM, Port: 21)<br>- VelociraptorClient (PID: 3375, User: ubuntu, )<br>- green_session (PID: 3383, User: GreenAgent, )<br>- RedAbstractSession (PID: 3389, User: SYSTEM, )<br>",
            "System info:<br>WINDOWS WINDOWS_SVR_2008 (x64)<br><br>Processes info:<br>- sshd.exe (PID: 3368, User: sshd_server, Port: 22)<br>- femitter.exe (PID: 3344, User: SYSTEM, Port: 21)<br>- VelociraptorClient (PID: 3377, User: ubuntu, )<br>- green_session (PID: 3382, User: GreenAgent, )<br>",
            "System info:<br>WINDOWS WINDOWS_SVR_2008 (x64)<br><br>Processes info:<br>- smss.exe (PID: 4, User: SYSTEM, Port: 445, Port: 139)<br>- svchost.exe (PID: 832, User: SYSTEM, Port: 135)<br>- svchost.exe (PID: 4400, User: NetworkService, Port: 3389)<br>- VelociraptorClient (PID: 4406, User: ubuntu, )<br>- green_session (PID: 4407, User: GreenAgent, )<br>",
            "System info:<br>LINUX UBUNTU (x64)<br><br>Processes info:<br>- mysql (PID: 1101, User: root, Port: 3389)<br>- apache2 (PID: 1100, User: www-data, Port: 80, Port: 443)<br>- smtp (PID: 1102, User: root, Port: 25)<br>- VelociraptorClient (PID: 1105, User: ubuntu, )<br>- green_session (PID: 1109, User: GreenAgent, )<br>",
            "System info:<br>LINUX UBUNTU (x64)<br><br>Processes info:<br>- sshd (PID: 1091, User: root, Port: 22)<br>- mysql (PID: 1101, User: root, Port: 3390)<br>- apache2 (PID: 1100, User: www-data, Port: 80, Port: 443)<br>- smtp (PID: 1102, User: root, Port: 25)<br>- VelociraptorClient (PID: 1105, User: ubuntu, )<br>- green_session (PID: 1110, User: GreenAgent, )<br>",
            "",
            "",
            ""
        ],
        "action_info": {
            "action": "Monitor",
            "success": "TRUE"
        },
        "host_map": {
            "Defender": "10.0.71.91",
            "Enterprise0": "10.0.71.86",
            "Enterprise1": "10.0.71.89",
            "Enterprise2": "10.0.71.90",
            "Op_Host0": "10.0.65.5",
            "Op_Host1": "10.0.65.11",
            "Op_Host2": "10.0.65.13",
            "Op_Server0": "10.0.65.12",
            "User0": "10.0.224.104",
            "User1": "10.0.224.99",
            "User2": "10.0.224.97",
            "User3": "10.0.224.108",
            "User4": "10.0.224.98",
            "Enterprise_router": "10.0.71.92",
            "Operational_router": "10.0.65.7",
            "User_router": "10.0.224.100"
        }
    },
    "Red": {
        "link_diagram": {
            "directed": false,
            "multigraph": false,
            "graph": {},
            "nodes": [
                {
                    "id": "Defender"
                },
                {
                    "id": "Enterprise0"
                },
                {
                    "id": "Enterprise1"
                },
                {
                    "id": "Enterprise2"
                },
                {
                    "id": "Op_Host0"
                },
                {
                    "id": "Op_Host1"
                },
                {
                    "id": "Op_Host2"
                },
                {
                    "id": "Op_Server0"
                },
                {
                    "id": "User0"
                },
                {
                    "id": "User1"
                },
                {
                    "id": "User2"
                },
                {
                    "id": "User3"
                },
                {
                    "id": "User4"
                },
                {
                    "id": "Enterprise_router"
                },
                {
                    "id": "Operational_router"
                },
                {
                    "id": "User_router"
                }
            ],
            "links": [
                {
                    "source": "Defender",
                    "target": "Enterprise_router"
                },
                {
                    "source": "Enterprise0",
                    "target": "Enterprise_router"
                },
                {
                    "source": "Enterprise1",
                    "target": "Enterprise_router"
                },
                {
                    "source": "Enterprise2",
                    "target": "Enterprise_router"
                },
                {
                    "source": "Op_Host0",
                    "target": "Operational_router"
                },
                {
                    "source": "Op_Host1",
                    "target": "Operational_router"
                },
                {
                    "source": "Op_Host2",
                    "target": "Operational_router"
                },
                {
                    "source": "Op_Server0",
                    "target": "Operational_router"
                },
                {
                    "source": "User0",
                    "target": "User_router"
                },
                {
                    "source": "User1",
                    "target": "User_router"
                },
                {
                    "source": "User2",
                    "target": "User_router"
                },
                {
                    "source": "User3",
                    "target": "User_router"
                },
                {
                    "source": "User4",
                    "target": "User_router"
                },
                {
                    "source": "Enterprise_router",
                    "target": "Operational_router"
                },
                {
                    "source": "Enterprise_router",
                    "target": "User_router"
                },
                {
                    "source": "Operational_router",
                    "target": "User_router"
                }
            ]
        },
        "node_colors": [
            "green",
            "green",
            "green",
            "green",
            "green",
            "green",
            "green",
            "green",
            "red",
            "green",
            "green",
            "green",
            "green",
            "green",
            "green",
            "rosybrown"
        ],
        "node_borders": [
            {
                "width": 0,
                "color": "white"
            },
            {
                "width": 0,
                "color": "white"
            },
            {
                "width": 0,
                "color": "white"
            },
            {
                "width": 0,
                "color": "white"
            },
            {
                "width": 0,
                "color": "white"
            },
            {
                "width": 0,
                "color": "white"
            },
            {
                "width": 0,
                "color": "white"
            },
            {
                "width": 0,
                "color": "white"
            },
            {
                "width": 0,
                "color": "white"
            },
            {
                "width": 0,
                "color": "white"
            },
            {
                "width": 0,
                "color": "white"
            },
            {
                "width": 0,
                "color": "white"
            },
            {
                "width": 0,
                "color": "white"
            },
            {
                "width": 0,
                "color": "white"
            },
            {
                "width": 0,
                "color": "white"
            },
            {
                "width": 2,
                "color": "black"
            }
        ],
        "compromised_hosts": [
            "User0"
        ],
        "host_info": [
            "System info:<br>LINUX UBUNTU (x64)<br><br>Processes info:<br>- init (PID: 1, User: root, )<br>- systemd-journald (PID: 389, User: root, )<br>- systemd-udevd (PID: 407, User: root, )<br>- lvmetad (PID: 409, User: root, )<br>- systemd-timesyncd (PID: 560, User: systemd+, )<br>- accounts-daemon (PID: 790, User: root, )<br>- atd (PID: 802, User: daemon, )<br>- bash (PID: 803, User: velocir+, )<br>- rsyslogd (PID: 807, User: syslog, )<br>- acpid (PID: 824, User: root, )<br>- snapd (PID: 825, User: root, )<br>- dbus-daemon (PID: 827, User: message+, )<br>- velociraptor.bin (PID: 832, User: velocir+, )<br>- cron (PID: 844, User: root, )<br>- systemd-logind (PID: 847, User: root, )<br>- python3 (PID: 852, User: root, )<br>- lxcfs (PID: 853, User: root, )<br>- polkitd (PID: 863, User: root, )<br>- python3 (PID: 867, User: root, )<br>- agetty (PID: 875, User: root, )<br>- agetty (PID: 884, User: root, )<br>- python3 (PID: 1370, User: root, )<br>- systemd-hostnamed (PID: 1432, User: root, )<br>- sshd (PID: 2288, User: root, )<br>- sshd (PID: 879, User: root, Port: 22)<br>- systemd-resolved (PID: 656, User: systemd+, Port: 53, Port: 53)<br>- systemd-networkd (PID: 634, User: systemd+, Port: 68)<br>- VelociraptorServer (PID: 2289, User: ubuntu, )<br>- VelociraptorClient (PID: 2298, User: ubuntu, )<br>",
            "System info:<br>LINUX UBUNTU (x64)<br><br>Processes info:<br>- sshd (PID: 1091, User: root, Port: 22)<br>- VelociraptorClient (PID: 1100, User: ubuntu, )<br>",
            "System info:<br>WINDOWS WINDOWS_SVR_2008 (x64)<br><br>Processes info:<br>- sshd.exe (PID: 3368, User: sshd_server, Port: 22)<br>- svchost.exe (PID: 832, User: SYSTEM, Port: 135)<br>- svchost.exe (PID: 4400, User: SYSTEM, Port: 3389)<br>- smss.exe (PID: 4, User: SYSTEM, Port: 445, Port: 139)<br>- tomcat8.exe (PID: 3404, User: NetworkService, Port: 80, Port: 443)<br>- VelociraptorClient (PID: 4405, User: SYSTEM, )<br>",
            "System info:<br>WINDOWS WINDOWS_SVR_2008 (x64)<br><br>Processes info:<br>- sshd.exe (PID: 3368, User: sshd_server, Port: 22)<br>- svchost.exe (PID: 832, User: SYSTEM, Port: 135)<br>- svchost.exe (PID: 4400, User: SYSTEM, Port: 3389)<br>- smss.exe (PID: 4, User: SYSTEM, Port: 445, Port: 139)<br>- tomcat8.exe (PID: 3404, User: NetworkService, Port: 80, Port: 443)<br>- VelociraptorClient (PID: 4409, User: SYSTEM, )<br>",
            "System info:<br>LINUX UBUNTU (x64)<br><br>Processes info:<br>- sshd (PID: 1091, User: root, Port: 22)<br>- VelociraptorClient (PID: 1099, User: ubuntu, )<br>- green_session (PID: 1108, User: GreenAgent, )<br>",
            "System info:<br>LINUX UBUNTU (x64)<br><br>Processes info:<br>- sshd (PID: 1091, User: root, Port: 22)<br>- VelociraptorClient (PID: 1093, User: ubuntu, )<br>- green_session (PID: 1101, User: GreenAgent, )<br>",
            "System info:<br>LINUX UBUNTU (x64)<br><br>Processes info:<br>- sshd (PID: 1091, User: root, Port: 22)<br>- VelociraptorClient (PID: 1098, User: ubuntu, )<br>- green_session (PID: 1104, User: GreenAgent, )<br>",
            "System info:<br>LINUX UBUNTU (x64)<br><br>Processes info:<br>- sshd (PID: 1091, User: root, Port: 22)<br>- OTService (PID: 1043, User: root, )<br>- VelociraptorClient (PID: 1099, User: ubuntu, )<br>",
            "System info:<br>WINDOWS WINDOWS_SVR_2008 (x64)<br><br>Processes info:<br>- sshd.exe (PID: 3368, User: sshd_server, Port: 22)<br>- femitter.exe (PID: 3344, User: SYSTEM, Port: 21)<br>- VelociraptorClient (PID: 3375, User: ubuntu, )<br>- green_session (PID: 3383, User: GreenAgent, )<br>- RedAbstractSession (PID: 3389, User: SYSTEM, )<br>",
            "System info:<br>WINDOWS WINDOWS_SVR_2008 (x64)<br><br>Processes info:<br>- sshd.exe (PID: 3368, User: sshd_server, Port: 22)<br>- femitter.exe (PID: 3344, User: SYSTEM, Port: 21)<br>- VelociraptorClient (PID: 3377, User: ubuntu, )<br>- green_session (PID: 3382, User: GreenAgent, )<br>",
            "System info:<br>WINDOWS WINDOWS_SVR_2008 (x64)<br><br>Processes info:<br>- smss.exe (PID: 4, User: SYSTEM, Port: 445, Port: 139)<br>- svchost.exe (PID: 832, User: SYSTEM, Port: 135)<br>- svchost.exe (PID: 4400, User: NetworkService, Port: 3389)<br>- VelociraptorClient (PID: 4406, User: ubuntu, )<br>- green_session (PID: 4407, User: GreenAgent, )<br>",
            "System info:<br>LINUX UBUNTU (x64)<br><br>Processes info:<br>- mysql (PID: 1101, User: root, Port: 3389)<br>- apache2 (PID: 1100, User: www-data, Port: 80, Port: 443)<br>- smtp (PID: 1102, User: root, Port: 25)<br>- VelociraptorClient (PID: 1105, User: ubuntu, )<br>- green_session (PID: 1109, User: GreenAgent, )<br>",
            "System info:<br>LINUX UBUNTU (x64)<br><br>Processes info:<br>- sshd (PID: 1091, User: root, Port: 22)<br>- mysql (PID: 1101, User: root, Port: 3390)<br>- apache2 (PID: 1100, User: www-data, Port: 80, Port: 443)<br>- smtp (PID: 1102, User: root, Port: 25)<br>- VelociraptorClient (PID: 1105, User: ubuntu, )<br>- green_session (PID: 1110, User: GreenAgent, )<br>",
            "",
            "",
            ""
        ],
        "action_info": {
            "action": "DiscoverRemoteSystems 10.0.224.96/28",
            "success": "TRUE"
        },
        "host_map": {
            "Defender": "10.0.71.91",
            "Enterprise0": "10.0.71.86",
            "Enterprise1": "10.0.71.89",
            "Enterprise2": "10.0.71.90",
            "Op_Host0": "10.0.65.5",
            "Op_Host1": "10.0.65.11",
            "Op_Host2": "10.0.65.13",
            "Op_Server0": "10.0.65.12",
            "User0": "10.0.224.104",
            "User1": "10.0.224.99",
            "User2": "10.0.224.97",
            "User3": "10.0.224.108",
            "User4": "10.0.224.98",
            "Enterprise_router": "10.0.71.92",
            "Operational_router": "10.0.65.7",
            "User_router": "10.0.224.100"
        }
    }
}
"""


final class CybORG_ARVizTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGraphWrapperDecoding() throws {
        // Convert the JSON string to Data
        guard let jsonData = testJSON.data(using: .utf8) else {
            XCTFail("Failed to convert test JSON to Data")
            return
        }

        // Attempt to decode the JSON to your GraphWrapper model
        let decoder = JSONDecoder()
        do {
            let decodedObject = try decoder.decode(GraphWrapper.self, from: jsonData)
            // If decoding succeeds, optionally inspect decodedObject to verify correctness
            XCTAssertNotNil(decodedObject, "Decoded object should not be nil")
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }

}
