import React, { Component } from 'react';
import {
  TouchableOpacity,
  View
} from 'react-native';
import DeviceInfo from 'react-native-device-info'
import EStyleSheet from 'react-native-extended-stylesheet'
import FontedText from '../common/FontedText'
import PropTypes from 'prop-types';

class ClassificationPanel extends Component {
  render() {
    const tabs =
      <View style={styles.tabContainer}>
        <TouchableOpacity
          onPress={ () => { this.props.setQuestionVisibility(true) } }
          style={ this.props.isQuestionVisible ? [styles.tab] : [styles.tab, styles.deselectedTab] }>
          <FontedText style={styles.tabText}>
            QUESTION
          </FontedText>
        </TouchableOpacity>
        <TouchableOpacity
          onPress={ () => { this.props.setQuestionVisibility(false) } }
          style={ this.props.isQuestionVisible ? [styles.tab, styles.deselectedTab] : [styles.tab] }>
          <FontedText style={styles.tabText}>
            TUTORIAL
          </FontedText>
        </TouchableOpacity>
      </View>

    return (
      <View style={styles.container}>
        <View style={styles.panelContainer}>
          { this.props.hasTutorial ? tabs : null }
          { this.props.children }
        </View>
      </View>
    )
  }
}

const styles = EStyleSheet.create({
  $panelHorizontalMargin: 25,
  container: {
    backgroundColor: '$lightestGrey',
    flex: 1,
    paddingBottom: 0,
  },
  panelContainer: {
    flex: 1,
    backgroundColor: 'white',
    marginTop: 15,
    marginBottom: 0,
    marginHorizontal: 25
  },
  tabContainer: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    alignItems: 'center'
  },
  tab: {
    alignItems: 'center',
    justifyContent: 'center',
    flex: 1,
    marginTop: 1,
  },
  deselectedTab: {
    backgroundColor: '$lightestGrey',
  },
  tabText: {
    fontSize: DeviceInfo.isTablet() ? 22 : 14,
    marginVertical: 15
  }
})

ClassificationPanel.propTypes = {
  isFetching: PropTypes.bool,
  hasTutorial: PropTypes.bool,
  children: PropTypes.node,
  isQuestionVisible: PropTypes.bool,
  setQuestionVisibility: PropTypes.func,
}
export default ClassificationPanel
