import UIKit

class PaintDisplay: UIViewController {
    
    let canvas = Canvas()
    var testImage: UIImage? = nil
    
    //creates share button
    let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleSaveAndExit), for: .touchUpInside)
        return button
    }()
    
    //
    //NEEDS WORK: DIRECTING SHARED PHOTO; turning canvas into image
    @objc func handleSaveAndExit(){
        save()
    }
    
    @IBAction func returnViewController(sender: AnyObject) {
        if((self.presentingViewController) != nil){
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func save()
    {
        let renderer = UIGraphicsImageRenderer(size: canvas.bounds.size)
        testImage = renderer.image { ctx in
            canvas.drawHierarchy(in: canvas.bounds, afterScreenUpdates: true)
        }
        testImage = cropToBounds(image: testImage!, width: 450, height: 900) //think about deleting
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        
        appDel.curCardController?.receiveDataFromModal(theImg: testImage!)
        print("saved! please help")
        
        if((self.presentingViewController) != nil){
            self.dismiss(animated: true, completion: nil)
        }
        //self.performSegue(withIdentifier: "unwindToCard", sender: nil)
    }
    
    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {
        
        let cgimage = image.cgImage!
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)
        
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImage = cgimage.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        
        return image
    }
    
    
    //create undo button
    let undoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Undo", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleUndo), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleUndo(){
        canvas.undo()
        
    }
    
    //creates clear button
    let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Clear", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleClear), for: .touchUpInside)
        return button
    }()
    
    @objc func handleClear(){
        canvas.clear()
    }
    
    //buttons
    let yellowButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .yellow
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    let redButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    let blueButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    let blackButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    let greenButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .green
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleColorChange(button: UIButton){
        canvas.setStrokeColor(color: button.backgroundColor ?? .black)
    }
    
    let slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue=1
        slider.maximumValue=10
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return slider
    }()
    
    @objc fileprivate func handleSliderChange(){
        canvas.setStrokeWidth(width: slider.value)
    }
    
    //setup background as white
    override func loadView() {
        self.view=canvas
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //setup background to white
        canvas.backgroundColor = .white
        
        setupLayout()
    }
    
    fileprivate func setupLayout(){
        
        //the stack of buttons
        let colorsStackView = UIStackView (arrangedSubviews:[blackButton,
                                                             yellowButton,
                                                             redButton,
                                                             blueButton,
                                                             greenButton])
        
        colorsStackView.distribution = .fillEqually
        
        let stackView=UIStackView(arrangedSubviews: [undoButton,
                                                     colorsStackView,
                                                     clearButton,
                                                     slider,
                                                     shareButton])
        stackView.spacing = 1
        stackView.distribution = .fillEqually
        
        //for location of buttons
        view.addSubview(stackView)
        
        //to manually move buttons
        //stackView.frame = CGRect(x:200,y:200,width:200, height:200)
        
        //places buttons
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -8).isActive = true
        
        
    }
    
}






