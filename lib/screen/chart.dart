import 'package:flutter/material.dart';
import 'package:hamdiappps/screen/profil.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Chat'),
        leading: IconButton(
// Tambahkan leading untuk tombol back
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
// Menggunakan pushReplacement agar tidak menumpuk halaman
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
      ),
      body: Stack(
// Wrap body with Stack
        children: <Widget>[
// Background Image
          Image.asset(
            'assets/images/white.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          ListView.builder(
            itemCount: chatList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(chatList[index].profileImage),
                ),
                title: Text(chatList[index].name),
                subtitle: Text(chatList[index].lastMessage),
                trailing: Text(chatList[index].time),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatDetail(chatList[index]),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class Chat {
  final String name;
  final String lastMessage;
  final String time;
  final String profileImage;
  Chat(this.name, this.lastMessage, this.time, this.profileImage);
}

final List<Chat> chatList = [
  Chat('John Doe', 'Hai, apa kabar?', '10:00', 'assets/images/user.jpg'),
  Chat('Jane Smith', 'Sampai jumpa!', '11:30', 'assets/images/user2.png'),
  Chat('Peter Jones', 'Oke, terima kasih.', '12:45', 'assets/images/user3.png'),
// Tambahkan data chat lainnya di sini
];

class ChatDetail extends StatefulWidget {
  final Chat chat;
  ChatDetail(this.chat);
  @override
  _ChatDetailState createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {
  final TextEditingController _messageController = TextEditingController();
  List<ChatMessage> _messages = [];
  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add(ChatMessage(
          message: _messageController.text,
          isMe: true,
        ));
        _messageController.clear();
      });
// Tambahkan logika untuk mengirim pesan ke server atau menyimpan pesan lokal
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.chat.name),
        leading: IconButton(
// Tambahkan leading untuk tombol back
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
// Menggunakan pushReplacement agar tidak menumpuk halaman
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
      ),
      body: Stack(
// Wrap body with Stack
        children: <Widget>[
// Background Image
          Image.asset(
            'assets/images/white.jpg', // isi dengan background image link

            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return _messages[index];
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Ketik pesan...',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: _sendMessage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String message;
  final bool isMe;
  ChatMessage({required this.message, required this.isMe});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: isMe ? Colors.blue[200] : Colors.grey[300],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(message),
        ),
      ),
    );
  }
}
