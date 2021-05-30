use smartcore::dataset::*;
// DenseMatrix wrapper around Vec
use smartcore::linalg::naive::dense_matrix::DenseMatrix;
// PCA
use smartcore::decomposition::pca::{PCAParameters, PCA};

fn main() {
    let digits_data = digits::load_dataset();
    // Transform dataset into a NxM matrix
    let x = DenseMatrix::from_array(
        digits_data.num_samples,
        digits_data.num_features,
        &digits_data.data,
    );
    // These are our target class labels
    let labels = digits_data.target;
    // Fit PCA to digits dataset
    let pca = PCA::fit(&x, PCAParameters::default().with_n_components(2)).unwrap();
    // Reduce dimensionality of X to 2 principal components
    let x_transformed = pca.transform(&x).unwrap();
}
