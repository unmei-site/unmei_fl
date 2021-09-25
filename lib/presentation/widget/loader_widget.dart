import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';

class LoaderWidget extends StatefulWidget {
  final Widget child;
  final double boxSize;
  final Color indicatorColor;
  final int durationAnim;
  final Function onRefresh;

  LoaderWidget({
    required this.child,
    this.boxSize = 150,
    required this.indicatorColor,
    this.durationAnim = 1,
    required this.onRefresh
  });

  @override
  _LoaderWidgetState createState() => _LoaderWidgetState();
}

class _LoaderWidgetState extends State<LoaderWidget> with SingleTickerProviderStateMixin {

  bool _renderCompleteState = false;

  final _helper = IndicatorStateHelper();

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      offsetToArmed: widget.boxSize,
      onRefresh: () {
        return Future.delayed(Duration(seconds: widget.durationAnim), () {
          return widget.onRefresh();
        });
      },
      child: widget.child,
      completeStateDuration: Duration(seconds: widget.durationAnim),
      builder: (context, child, controller) {
        return Stack(
          children: [
            AnimatedBuilder(
              animation: controller,
              builder: (context, _) {
                _helper.update(controller.state);
                if (_helper.didStateChange(to: IndicatorState.complete)) _renderCompleteState = true;
                else if (_helper.didStateChange(to: IndicatorState.idle)) _renderCompleteState = false;

                final containerHeight = controller.value * widget.boxSize;

                return Opacity(
                  opacity: controller.value.clamp(0.0, 1.0),
                  child: Container(
                    alignment: Alignment.center,
                    height: containerHeight,
                    child: OverflowBox(
                      maxHeight: 40,
                      minHeight: 40,
                      maxWidth: 40,
                      minWidth: 40,
                      alignment: Alignment.center,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 150),
                        alignment: Alignment.center,
                        child: _renderCompleteState ? Icon(Icons.check, color: Colors.white) : SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                            value: controller.isDragging || controller.isArmed ? controller.value.clamp(0.0, 1.0) : null,
                          ),
                        ),
                        decoration: BoxDecoration(color: _renderCompleteState ? widget.indicatorColor : Colors.black,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            AnimatedBuilder(
              builder: (context, _) {
                return Transform.translate(
                  offset: Offset(0.0, controller.value * widget.boxSize),
                  child: child,
                );
              },
              animation: controller,
            ),
          ],
        );
      },
    );
  }
}