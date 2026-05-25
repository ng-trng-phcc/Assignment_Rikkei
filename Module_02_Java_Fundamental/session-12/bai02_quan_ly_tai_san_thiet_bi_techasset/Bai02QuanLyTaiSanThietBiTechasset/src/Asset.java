// Abstract Class Asset
public abstract class Asset {
    protected String assetCode;
    protected String name;
    protected double purchasePrice;

    public Asset(String assetCode, String name, double purchasePrice) {
        this.assetCode = assetCode;
        this.name = name;
        this.purchasePrice = purchasePrice;
    }

    // Phương thức trừu tượng tính giá trị thị trường sau khấu hao
    public abstract double getMarketValue();

    // Getters và Setters
    public String getAssetCode() {
        return assetCode;
    }

    public void setAssetCode(String assetCode) {
        this.assetCode = assetCode;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPurchasePrice() {
        return purchasePrice;
    }

    public void setPurchasePrice(double purchasePrice) {
        this.purchasePrice = purchasePrice;
    }

    @Override
    public String toString() {
        return String.format("Mã: %s | Tên: %s | Giá mua: %,.2f VND | Giá hiện tại: %,.2f VND",
                assetCode, name, purchasePrice, getMarketValue());
    }
}