class Level {

  Level(ArrayList<Block> b) {
    for (int i = 0; i < b.size(); i++) {
      blockList.add(b.get(i));
    }
  }

  void removeAllBlocks() {
    for (int i = blockList.size(); i > 0; i--) {
      blockList.remove(i-1);
    }
    for (int i = mure.size(); i > 0; i--) {
      mure.remove(i-1);
    }
  }
}
