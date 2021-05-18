import 'dart:core';

class Message {
  String _sendMessage;
  bool _fromMe;
  String _takeMessage;
  String _message;
  DateTime _date;

  Message(this._sendMessage, this._fromMe, this._takeMessage, this._message,
      this._date);

  DateTime get date => _date;

  String get message => _message;

  String get takeMessage => _takeMessage;

  bool get fromMe => _fromMe;

  String get sendMessage => _sendMessage;

  Map<String, dynamic> toMap() {
    return {
      "sendMessage": _sendMessage,
      "fromMe": _fromMe,
      "takeMessage": _takeMessage,
      "message": _message,
      "date": _date,
    };
  }

  Message.fromMap(Map<String, dynamic> map)
      : _sendMessage = map['sendMessage'],
        _fromMe = map['fromMe'],
        _takeMessage = map['takeMessage'],
        _message = map['message'],
        _date = map['date'];
}
