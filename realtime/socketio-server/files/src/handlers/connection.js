module.exports = function registerConnectionHandlers(io, socket) {
  console.log(`User connected: ${socket.id}`);

  socket.on("disconnect", () => {
    console.log(`User disconnected: ${socket.id}`);
    io.emit("user-disconnected", { id: socket.id });
  });
};
