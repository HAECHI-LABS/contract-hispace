function getEventArgs(receipt, event) {
    const filtered = receipt.logs.filter(x => x.event == event);
      return filtered.map(x => x.args)[0];
}

exports.getEventArgs = getEventArgs;
