
/**
 * @brief The QgsFieldModel class is a model to display the list of fields of a layer in widgets.
 * If allowed, expressions might be added to the end of the model.
 * It can be associated with a QgsMapLayerModel to dynamically display a layer and its fields.
 * @note added in 2.3
 */
class QgsFieldModel : QAbstractItemModel
{
%TypeHeaderCode
#include "qgsfieldmodel.h"
%End

  public:
    enum FieldRoles {
      /* SIP does not accept any arithmetic" */
      FieldNameRole = 33,  /* return field name if index corresponds to a field */
      FieldIndexRole = 34, /* return field index if index corresponds to a field */
      ExpressionRole = 35, /* return field name or expression */
      IsExpressionRole = 36, /* return if index corresponds to an expression */
      ExpressionValidityRole = 37, /* return if expression is valid or not */
      FieldTypeRole = 38 /* return the field type (if a field, return QVariant if expression) */
    };

    /**
     * @brief QgsFieldModel creates a model to display the fields of a given layer
     */
    explicit QgsFieldModel( QObject *parent /TransferThis/ = 0 );

    //! return the index corresponding to a given fieldName
    QModelIndex indexFromName( QString fieldName );

    //! returns the currently used layer
    void setAllowExpression( bool allowExpression );
    bool allowExpression();

    /**
     * @brief setExpression sets a single expression to be added after the fields at the end of the model
     * @return the model index of the newly added expression
     */
    QModelIndex setExpression( QString expression );

    //! remove expressions from the model
    void removeExpression();

    //! returns the currently used layer
    QgsVectorLayer* layer();

  public slots:
    //! set the layer of whch fields are displayed
    void setLayer( QgsVectorLayer *layer );

  protected slots:
    virtual void updateModel();

    // QAbstractItemModel interface
  public:
    QModelIndex index( int row, int column, const QModelIndex &parent = QModelIndex() ) const;
    QModelIndex parent( const QModelIndex &child ) const;
    int rowCount( const QModelIndex &parent = QModelIndex() ) const;
    int columnCount( const QModelIndex &parent ) const;
    QVariant data( const QModelIndex &index, int role ) const;

};
