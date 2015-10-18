/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

var React = require('react-native');
var {
  AppRegistry,
  StyleSheet,
  Text,
    View,
    NativeModules,
    TouchableHighlight,
} = React;


var blinkerBoard = [
    [false, false, false, false, false],
    [false, false, false, false, false],
    [false, true, true, true, false],
    [false, false, false, false, false],
    [false, false, false, false, false]
];
    
console.log("mihir");
var LifeController = NativeModules.LifeController;
console.log(LifeController);
LifeController.nextBoardAsync(blinkerBoard, nextBoard => {
    console.log(nextBoard);
});

var Button = require('react-native-button');
var _ = require('underscore');

var reactconway = React.createClass({
    getInitialState() {
	return {'board' : blinkerBoard}
    },
    
    onButtonPress: function(event) {
	LifeController.nextBoardAsync(this.state.board, nextBoard => {
	    this.setState( { 'board' : nextBoard });
	});
    },
    onCellPress: function(rowIndex, cellIndex) {
	var board = this.state.board;
	board[rowIndex][cellIndex] = !board[rowIndex][cellIndex];
	this.setState( {board:board} );
    },
    
    render: function() {
    return (
	    <View style={styles.container}>
	    <Button
	style={styles.button}
	onPress={this.onButtonPress}>
	    Press Me!
	      </Button>
	    <Grid data={this.state.board} onCellPress={this.onCellPress} />
      </View>
    );
  }
});

var Grid = React.createClass({
    
    render: function() {
	var data = this.props.data;
	var markup = [];
	
	_.each(data, (row, rowIndex) => {
	    var rowMarkup = [];

	    _.each(row, (cell, cellIndex) => {
		var style = [styles.cell, cell ? styles.aliveCell : styles.deadCell];
		var onPress = _.partial(this.props.onCellPress, rowIndex, cellIndex);
		rowMarkup.push(
			<TouchableHighlight onPress={onPress}>
			<View style={style}  />
			</TouchableHighlight>
		);
	    });
	    markup.push(<View style={styles.boardRow}>{rowMarkup}</View>);
	});
	
	return (
	   <View>
		{markup}
	    </View>
	);
    }
})

var styles = StyleSheet.create({
    aliveCell: {
	backgroundColor: 'blue',
    },
    deadCell: {
	backgroundColor: 'red',
    },
    boardRow: {
	flexDirection: 'row',
    },
    cell: {
	width: 20,
	height: 20,
	textAlign: 'center',
	margin: 1,
    },
    button: {
	borderWidth: 1,
	borderColor: 'black',
    },
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

AppRegistry.registerComponent('reactconway', () => reactconway);
