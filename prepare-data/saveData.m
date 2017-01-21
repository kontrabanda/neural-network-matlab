function saveData(train, test)
    save('../../resource/data/train.txt', 'train', '-ascii');
    save('../../resource/data/test.txt', 'test', '-ascii');