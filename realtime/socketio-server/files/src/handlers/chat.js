module.exports = function registerChatHandlers(io, socket) {
  socket.on("join-room", (room) => {
    socket.join(room);
    socket.emit("room-joined", { room });
    socket.to(room).emit("user-connected", { id: socket.id, room });
    console.log(`${socket.id} joined room: ${room}`);
  });

  socket.on("leave-room", (room) => {
    socket.leave(room);
    socket.to(room).emit("user-disconnected", { id: socket.id, room });
    console.log(`${socket.id} left room: ${room}`);
  });

  socket.on("chat-message", ({ room, message }) => {
    io.to(room).emit("message", {
      id: socket.id,
      message,
      room,
      timestamp: new Date().toISOString(),
    });
  });
};
