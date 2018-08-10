@interface _UIBatteryView : UIView
	@property(nonatomic, retain) CALayer * fillLayer;
	@property(nonatomic, assign, readwrite) NSInteger chargingState;
	@property(nonatomic, assign, readwrite) BOOL saverModeActive;
	- (void)_updateFillLayer;
@end

%hook _UIBatteryView

	- (void)_updateFillLayer {
		%orig;
		if(self.chargingState == 0) {
			[self.fillLayer removeAllAnimations];
		}
		else if (!self.saverModeActive) {
			[self.fillLayer removeAllAnimations];
			CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
			pulseAnimation.fromValue = (__bridge id)[UIColor colorWithRed: (7.6/25.5) green: (21.7/25.5) blue: (10/25.5) alpha: 1].CGColor;
			pulseAnimation.toValue = (__bridge id)[UIColor colorWithRed: (5/25.5) green: (15.5/25.5) blue: (7/25.5) alpha: 1].CGColor;
			pulseAnimation.duration = 1;
			pulseAnimation.repeatCount = INFINITY;
			pulseAnimation.autoreverses = YES;
			[self.fillLayer addAnimation:pulseAnimation forKey:@"backgroundColor"];
		}
		else {
			[self.fillLayer removeAllAnimations];
			CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
			pulseAnimation.fromValue = (__bridge id)[UIColor colorWithRed: 1 green: 0.8 blue: 0 alpha: 1].CGColor;
			pulseAnimation.toValue = (__bridge id)[UIColor colorWithRed: (21/25.5) green: (17/25.5) blue: (1/25.5) alpha: 1].CGColor;
			pulseAnimation.duration = 1;
			pulseAnimation.repeatCount = INFINITY;
			pulseAnimation.autoreverses = YES;
			[self.fillLayer addAnimation:pulseAnimation forKey:@"backgroundColor"];
		}
	}

	- (void)setSaverModeActive:(BOOL)arg1 {
		%orig;
		[self _updateFillLayer];
	}

%end