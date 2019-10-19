import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private var scrollView: UIScrollView!
    private var pageControl: UIPageControl!
    
    var image:[[String]]? = [["meat1","meat2","meat4","meat5"],["meat2","meat3"],["meat3","meat4"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tablesettings()
        
    }
}

// scrollViewのページ移動に合わせてpageControlの表示も移動させる
extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tablesettings(){
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (image?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for:indexPath) as! PhotoViewTableViewCell
        
        let tablenumber = indexPath.row
        let photonumber = image?[indexPath.row].count
        cell.setImage(image: image!, tablenumber: tablenumber, photonumber: photonumber!, view: view)
        return cell
    }
    
    
}
