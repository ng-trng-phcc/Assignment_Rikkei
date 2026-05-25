// Class Computer kế thừa từ Asset
public class Computer extends Asset {
    private String ram;
    private String cpu;
    private static final double DEPRECIATION_RATE = 0.20; // Khấu hao 20%/năm

    public Computer(String assetCode, String name, double purchasePrice, String ram, String cpu) {
        super(assetCode, name, purchasePrice);
        this.ram = ram;
        this.cpu = cpu;
    }

    @Override
    public double getMarketValue() {
        // Giả sử tính khấu hao 1 năm
        return purchasePrice * (1 - DEPRECIATION_RATE);
    }

    // Getters và Setters
    public String getRam() {
        return ram;
    }

    public void setRam(String ram) {
        this.ram = ram;
    }

    public String getCpu() {
        return cpu;
    }

    public void setCpu(String cpu) {
        this.cpu = cpu;
    }

    @Override
    public String toString() {
        return String.format("MÁY TÍNH | %s | RAM: %s | CPU: %s",
                super.toString(), ram, cpu);
    }
}