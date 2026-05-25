// Class NetworkDevice kế thừa từ Asset
public class NetworkDevice extends Asset {
    private int numberOfPorts;
    private static final double DEPRECIATION_RATE = 0.10; // Khấu hao 10%/năm

    public NetworkDevice(String assetCode, String name, double purchasePrice, int numberOfPorts) {
        super(assetCode, name, purchasePrice);
        this.numberOfPorts = numberOfPorts;
    }

    @Override
    public double getMarketValue() {
        // Giả sử tính khấu hao 1 năm
        return purchasePrice * (1 - DEPRECIATION_RATE);
    }

    // Getters và Setters
    public int getNumberOfPorts() {
        return numberOfPorts;
    }

    public void setNumberOfPorts(int numberOfPorts) {
        this.numberOfPorts = numberOfPorts;
    }

    @Override
    public String toString() {
        return String.format("THIẾT BỊ MẠNG | %s | Số cổng: %d",
                super.toString(), numberOfPorts);
    }
}