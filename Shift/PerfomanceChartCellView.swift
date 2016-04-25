//
//  PerfomanceChartCellView.swift
//  Shift
//
//  Created by Scaria on 4/24/16.
//  Copyright © 2016 Meredith Moore. All rights reserved.
//

import Foundation
import Charts
import MaterialTextField


class PerfomanceChartCellView: UITableViewCell, UITextFieldDelegate, ChartViewDelegate{
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var fromText: MFTextField!
    @IBOutlet weak var toText: MFTextField!
    @IBOutlet weak var chartView: LineChartView!
    var fromDate : NSDate?
    var toDate : NSDate?
    var dateFormatter:NSDateFormatter?
    var xVals:Array<NSTimeInterval> = Array<NSTimeInterval>()
    var yVals:Array<Int> = Array<Int>()
    var exercise: String?
    
    override func layoutSubviews() {
        self.textFieldsSetup()
        self.cardViewSetup()
        self.chartViewSetup()
        LoginServices.sharedInstance.getExerciseRecords(self.exercise!, executeAfter: { time, score in
            self.xVals = time
            self.yVals = score
            self.setupData()
        
        })
        
    }
    
    func isDateSameOrLaterFromDate(date:NSDate) -> Bool{
        return (date.compare(self.fromDate!) == .OrderedDescending || date.compare(self.fromDate!) == .OrderedSame)
    }
    
    func isDateSameOrEarlierToDate(date:NSDate) -> Bool{
        return (date.compare(self.toDate!) == .OrderedAscending || date.compare(self.toDate!) == .OrderedSame)
    }
    
    func setupData(){
        var localXVals = Array<String>()
        var localYVals = Array<ChartDataEntry>()
        for index in 0..<self.xVals.count {
            let date: NSDate = NSDate(timeIntervalSince1970: self.xVals[index])
            if(self.isDateSameOrLaterFromDate(date) && self.isDateSameOrEarlierToDate(date)){
                localXVals.append(self.dateFormatter!.stringFromDate(date))
                localYVals.append(ChartDataEntry(value: Double(self.yVals[index]) , xIndex: index))
            }
        }
        
        let set1 = LineChartDataSet(yVals: localYVals, label: "Exercise score")
        
        set1.lineDashLengths = [5.0, 2.5]
        set1.highlightLineDashLengths = [5.0, 2.5]
        set1.setColor(UIColor.blackColor())
        set1.setCircleColor(UIColor.blackColor())

        set1.lineWidth = 1.0;
        set1.circleRadius = 3.0;
        set1.drawCircleHoleEnabled = false;
        set1.valueFont = UIFont.systemFontOfSize(9.0)
        //set1.fillAlpha = 65/255.0;
        //set1.fillColor = UIColor.blackColor;
        
        let gradientColors:NSArray = [
            ChartColorTemplates.colorFromString("#00ff0000").CGColor,
            ChartColorTemplates.colorFromString("#ffff0000").CGColor
        ]
        let  gradient:CGGradientRef = CGGradientCreateWithColors(nil, gradientColors as CFArrayRef, nil)!
        
        set1.fillAlpha = 1.0
        set1.fill = ChartFill.fillWithLinearGradient(gradient, angle: 90.0)
        set1.drawFilledEnabled = true
        
        let  dataSets:NSMutableArray = NSMutableArray()
        dataSets.addObject(set1)
        
        
        let data:LineChartData = LineChartData(xVals: localXVals, dataSet: set1)
        chartView.data = data;
    
    }
    
    
    func setupDatePicker() -> UIDatePicker{
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        
        return datePickerView
    }
    
    func textFieldsSetup(){
        self.toDate = NSDate()
        let monthComponent = NSDateComponents()
        monthComponent.month = -1
        self.fromDate = NSCalendar.currentCalendar().dateByAddingComponents(monthComponent , toDate: self.toDate!, options: .WrapComponents)!
        
        self.dateFormatter = NSDateFormatter()
        self.dateFormatter!.dateStyle = NSDateFormatterStyle.MediumStyle
        self.dateFormatter!.timeStyle = NSDateFormatterStyle.NoStyle
        
        self.toText!.text = self.dateFormatter!.stringFromDate(self.toDate!)
        self.fromText!.text = self.dateFormatter!.stringFromDate(self.fromDate!)
        
        
    }
    
    @IBAction func toTextPick(sender: UITextField) {
        let datePickerView = setupDatePicker()
        datePickerView.date = self.toDate!
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.updateToText(_:)), forControlEvents: .ValueChanged)
    }
    
    
    @IBAction func fromTextPick(sender: UITextField) {
        let datePickerView = setupDatePicker()
        datePickerView.date = self.fromDate!
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.updateFromText(_:)), forControlEvents: .ValueChanged)
    }


    
    func updateFromText(sender: UIDatePicker){
        self.fromDate = sender.date
        self.fromText!.text = self.dateFormatter!.stringFromDate(sender.date)
        self.fromText!.resignFirstResponder()
        
        self.setupData()
    }
    
    func updateToText(sender: AnyObject){
        self.toDate = sender.date
        self.toText!.text = self.dateFormatter!.stringFromDate(sender.date)
        self.toText!.resignFirstResponder()
        
        self.setupData()
    }
    
    func cardViewSetup(){
        self.cellView!.alpha = 1.0;
        self.cellView!.layer.masksToBounds = false;
        self.cellView!.layer.cornerRadius = 15.0;
        self.cellView!.layer.shadowOffset = CGSizeMake(-0.1, 0.1)
        self.cellView!.layer.shadowOpacity = 0.2
    }
    
    func chartViewSetup(){
        self.chartView!.layer.cornerRadius = 10.0;
        self.chartView!.delegate = self
        chartView!.descriptionText = "Description"
        chartView!.noDataTextDescription = "No exercise data found"
        
        chartView!.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView!.pinchZoomEnabled = true
        chartView!.drawGridBackgroundEnabled = false
        
        
        // x-axis limit line
        let llXAxis:ChartLimitLine = ChartLimitLine(limit: 10.0, label: "Index 10")
        llXAxis.lineWidth = 4.0;
        llXAxis.lineDashLengths = [10.0, 10.0, 0.0]
        llXAxis.labelPosition = ChartLimitLine.ChartLimitLabelPosition.RightBottom
        llXAxis.valueFont = UIFont.systemFontOfSize(10.0)
        
        //[_chartView.xAxis addLimitLine:llXAxis];
        
//        ChartLimitLine *ll1 = [[ChartLimitLine alloc] initWithLimit:130.0 label:@"Upper Limit"];
//        ll1.lineWidth = 4.0;
//        ll1.lineDashLengths = @[@5.f, @5.f];
//        ll1.labelPosition = ChartLimitLabelPositionRightTop;
//        ll1.valueFont = [UIFont systemFontOfSize:10.0];
//        
//        ChartLimitLine *ll2 = [[ChartLimitLine alloc] initWithLimit:-30.0 label:@"Lower Limit"];
//        ll2.lineWidth = 4.0;
//        ll2.lineDashLengths = @[@5.f, @5.f];
//        ll2.labelPosition = ChartLimitLabelPositionRightBottom;
//        ll2.valueFont = [UIFont systemFontOfSize:10.0];
        
        let leftAxis:ChartYAxis = chartView!.leftAxis;
        leftAxis.removeAllLimitLines()
        leftAxis.axisMaxValue = 100.0
        leftAxis.axisMinValue = 0.0
        leftAxis.gridLineDashLengths = [5.0, 5.0]
        leftAxis.drawZeroLineEnabled = false
        leftAxis.drawLimitLinesBehindDataEnabled = true

        chartView!.rightAxis.enabled = false;
        
        //[_chartView.viewPortHandler setMaximumScaleY: 2.f];
        //[_chartView.viewPortHandler setMaximumScaleX: 2.f];
        
        //let marker:BalloonMarker
        
//        let marker:  = [[BalloonMarker alloc] initWithColor:[UIColor colorWithWhite:180/255. alpha:1.0] font:[UIFont systemFontOfSize:12.0] insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)];
//        marker.minimumSize = CGSizeMake(80.f, 40.f);
//        _chartView.marker = marker;
//        
//        _chartView.legend.form = ChartLegendFormLine;
//        
//        _sliderX.value = 44.0;
//        _sliderY.value = 100.0;
//        [self slidersValueChanged:nil];
        
        chartView!.animate(xAxisDuration: 2.5, easingOption: ChartEasingOption.EaseInOutQuad)
        
    }
    
    
    
    
}
