import RevoSockets

public class Balance {
    let socket:SocketClient
    
    public init(ip:String, port:UInt16 = 23) {
        socket = SocketClient(host: ip, port: port)
    }
    
    public func start(_ debug:Bool = false) async throws {
        try await socket.start(debug: debug)
    }
    
    public func getWeight(tries:Int = 3) async throws -> Double{
        socket.send("$")
        do {
            guard let result = try await socket.readAsString(to: "\r", timeoutMs: 500) else {
                return 0
            }
            return Double(result) ?? 0
        }catch {
            if tries > 0 {
                return try await getWeight(tries: tries - 1)
            }
            throw error
        }
    }
    
    public func stop(){
        socket.stop()
    }
}
