import Buffer "mo:base/Buffer";
import Time "mo:base/Time";
import Text "mo:base/Text";
import Int "mo:base/Int";

actor {
    type Message = {
        user: Text;
        content: Text;
        timestamp: Int;
    };

    stable var messageStore: [Message] = [];
    let messages = Buffer.Buffer<Message>(0);

    public func sendMessage(user: Text, content: Text): async () {
        let message: Message = {
            user = user;
            content = content;
            timestamp = Time.now();
        };
        messages.add(message);
    };

    public query func getMessages(): async [Message] {
        Buffer.toArray(messages)
    };
};
