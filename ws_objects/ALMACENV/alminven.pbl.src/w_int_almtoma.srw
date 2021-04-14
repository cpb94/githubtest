$PBExportHeader$w_int_almtoma.srw
$PBExportComments$Toma de inventario.
forward
global type w_int_almtoma from w_int_con_empresa
end type
type cb_1 from u_boton within w_int_almtoma
end type
type uo_marca_lista from u_marca_lista within w_int_almtoma
end type
type st_1 from statictext within w_int_almtoma
end type
type em_fecha from u_em_campo within w_int_almtoma
end type
type pb_1 from upb_salir within w_int_almtoma
end type
type dw_tomas from datawindow within w_int_almtoma
end type
type report_almtoma from datawindow within w_int_almtoma
end type
type pb_2 from upb_imprimir within w_int_almtoma
end type
type pb_borrar from upb_papelera within w_int_almtoma
end type
type ddlb_1 from dropdownlistbox within w_int_almtoma
end type
type gb_1 from groupbox within w_int_almtoma
end type
end forward

global type w_int_almtoma from w_int_con_empresa
integer width = 2875
integer height = 1548
cb_1 cb_1
uo_marca_lista uo_marca_lista
st_1 st_1
em_fecha em_fecha
pb_1 pb_1
dw_tomas dw_tomas
report_almtoma report_almtoma
pb_2 pb_2
pb_borrar pb_borrar
ddlb_1 ddlb_1
gb_1 gb_1
end type
global w_int_almtoma w_int_almtoma

type variables
string filtro
integer anyo
end variables

forward prototypes
public function boolean toma_inv (string arg_codigo_empresa, string arg_codigo_almacen, date arg_fecha)
end prototypes

public function boolean toma_inv (string arg_codigo_empresa, string arg_codigo_almacen, date arg_fecha);str_almlinubica linubi
str_almtoma     toma
str_alminv      inven
Integer         bien,contador,registros,x1
Datetime fecha
String sel,activo
dec cajas,pallets
DataStore d
fecha = datetime(arg_fecha)

Select max(almtoma.linea) Into :contador From almtoma
Where  almtoma.empresa   =  :arg_codigo_empresa
and    almtoma.fecha_inv =  :fecha 
and    almtoma.almacen   =  :arg_codigo_almacen
Group BY almtoma.empresa,almtoma.fecha_inv,almtoma.almacen,almtoma.linea
ORDER BY almtoma.empresa asc, almtoma.fecha_inv asc, almtoma.almacen asc,
         almtoma.linea asc USING SQLCA;
IF contador<>0 THEN
   MessageBox("La toma ya existe alm almacen" + arg_codigo_almacen,"Ya Existe una toma a esta fecha",Exclamation!, OK!,1)
   bien=1
   Return FALSE
END IF

bien=0

Sel=  "SELECT almlinubica.empresa,almlinubica.almacen,almlinubica.zona,"+&   
      "   almlinubica.fila,almlinubica.altura,almlinubica.linea,"+&   
      "   almlinubica.articulo,almlinubica.familia,almlinubica.formato,"+&   
      "   almlinubica.modelo,almlinubica.calidad,almlinubica.tonochar,"+&   
      "   almlinubica.calibre,almlinubica.existencias,almlinubica.anyo,"+&   
      "   almlinubica.pedido,almlinubica.linped,almlinubica.ubicacion,"+&   
      "   almlinubica.tipo_unidad,almlinubica.referencia,almlinubica.f_alta,"+&
      "   almlinubica.observaciones,almlinubica.tipo_pallet,almlinubica.caja,"+&
		"   almlinubica.cliente"+&   
      "   FROM almlinubica "+& 
    	" WHERE almlinubica.empresa     = '"+arg_codigo_empresa+"'" +&
	   "    AND almlinubica.almacen    = '"+arg_codigo_almacen+"'"



//d = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, d)

registros = d.RowCount()
f_mensaje_proceso("Espere Por Favor ",0,100)

IF registros  <> 0 Then
 FOR x1= 1 To registros
  linubi.empresa        = d.GetItemString(x1,"empresa")
  linubi.almacen        = d.GetItemString(x1,"almacen")
  linubi.zona           = d.GetItemString(x1,"zona")
  linubi.fila           = d.GetItemNumber(x1,"fila")
  linubi.altura         = d.GetItemNumber(x1,"altura")
  linubi.linea          = d.GetItemNumber(x1,"linea")
  linubi.articulo       = d.GetItemString(x1,"articulo")
  linubi.familia        = d.GetItemString(x1,"familia")
  linubi.formato        = d.GetItemString(x1,"formato")
  linubi.modelo         = d.GetItemString(x1,"modelo")
  linubi.calidad        = d.GetItemString(x1,"calidad")
  linubi.tonochar       = d.GetItemstring(x1,"tonochar")
  linubi.calibre        = d.GetItemNumber(x1,"calibre")
  linubi.existencias    = d.GetItemNumber(x1,"existencias")
  linubi.anyo           = d.GetItemNumber(x1,"anyo")
  linubi.pedido         = d.GetItemNumber(x1,"pedido")
  linubi.linped         = d.GetItemNumber(x1,"linped")
  linubi.cliente        = d.GetItemString(x1,"cliente")
  linubi.ubicacion      = d.GetItemString(x1,"ubicacion")
  linubi.tipo_unidad    = d.GetItemString(x1,"tipo_unidad")
  linubi.referencia     = d.GetItemString(x1,"referencia")
  linubi.f_alta         = d.GetItemdatetime(x1,"f_alta")
  linubi.observaciones  = d.GetItemString(x1,"observaciones")
  linubi.tipo_pallet    = d.GeTItemString(x1,"tipo_pallet")
  linubi.caja           = d.GeTItemString(x1,"caja")  
  toma.fecha_alta       = DateTime(today(),now())
  toma.fecha_inv        = fecha
  toma.empresa          = linubi.empresa
  toma.almacen          = linubi.almacen   
  toma.zona             = linubi.zona
  toma.fila             = linubi.fila
  toma.altura           = linubi.altura
  toma.linea            = x1
  toma.articulo         = linubi.articulo
  toma.familia          = linubi.familia   
  toma.formato          = linubi.formato
  toma.modelo           = linubi.modelo   
  toma.calidad          = linubi.calidad
  toma.tonochar         = linubi.tonochar
  toma.calibre          = linubi.calibre
  toma.existencias      = linubi.existencias   
  toma.anyo             = linubi.anyo
  toma.pedido           = linubi.pedido   
  toma.linped           = linubi.linped
  toma.cliente          = linubi.cliente
  toma.ubicacion        = linubi.ubicacion
  toma.tipo_unidad      = linubi.tipo_unidad   
  toma.referencia       = linubi.referencia
  toma.f_alta           = linubi.f_alta 
  toma.observaciones    = linubi.observaciones
  toma.tipo_pallet      = linubi.tipo_pallet
  toma.caja             = linubi.caja
  toma.anyo_inv         = year(date(fecha))
  toma.usuario          = nombre_usuario

   INSERT INTO almtoma 
     (empresa,almacen,zona,fila,altura,linea,articulo,familia,formato,   
      modelo,calidad,tonochar,calibre,existencias,anyo,pedido,linped,cliente,   
      ubicacion,tipo_unidad,referencia,f_alta,observaciones,fecha_inv,   
      fecha_alta,tipo_pallet,anyo_inv,usuario,caja)  
      VALUES (:toma.empresa,:toma.almacen,:toma.zona,:toma.fila,:toma.altura,   
              :toma.linea,:toma.articulo,:toma.familia,:toma.formato,
              :toma.modelo,:toma.calidad,:toma.tonochar,:toma.calibre,
              :toma.existencias,:toma.anyo,:toma.pedido,:toma.linped,
              :toma.cliente,:toma.ubicacion,:toma.tipo_unidad,:toma.referencia,   
              :toma.f_alta,:toma.observaciones,:toma.fecha_inv,
              :toma.fecha_alta,:toma.tipo_pallet,:toma.anyo_inv,
				  :nombre_usuario,:toma.caja)USING SQLCA;
              IF SQLCA.SQLCode<>0 THEN  bien=1
				  
				   pallets          = f_calculo_pallets(toma.empresa,toma.articulo,&
                         toma.tipo_pallet,toma.caja,toma.existencias)
					cajas            = f_calculo_cajas(toma.empresa,toma.articulo,&
                         toma.tipo_pallet,toma.caja,pallets,toma.existencias)
								 
activo = "S"								 								 
IF Not IsNull(toma.pedido) Then activo = "N"

	  INSERT INTO alminvent
     (empresa,almacen,zona,fila,altura,linea,articulo,familia,formato,   
      modelo,calidad,tonochar,calibre,existencias,anyo,pedido,linped,cliente,   
      ubicacion,tipo_unidad,referencia,f_alta,observaciones,fecha_inv,   
      fecha_alta,tipo_pallet,caja,anyo_inv,cajas,pallets,fecha_actualizado,
		usuario,zonat,filat,alturat,tonotchar,calibret,existenciast,tipo_pallett,referenciat,activo)  
      VALUES (:toma.empresa,:toma.almacen,:toma.zona,:toma.fila,:toma.altura,   
              :toma.linea,:toma.articulo,:toma.familia,:toma.formato,
              :toma.modelo,:toma.calidad,:toma.tonochar,:toma.calibre,
              :toma.existencias,:toma.anyo,:toma.pedido,:toma.linped,
              :toma.cliente,:toma.ubicacion,:toma.tipo_unidad,:toma.referencia,   
              :toma.f_alta,:toma.observaciones,:toma.fecha_inv,
              :toma.fecha_alta,:toma.tipo_pallet,:toma.caja,:toma.anyo_inv,
				  :cajas,:pallets,null,:nombre_usuario,:toma.zona,:toma.fila,:toma.altura,
				  :toma.tonochar,:toma.calibre,:toma.existencias,:toma.tipo_pallet,:toma.referencia,:activo)USING SQLCA;
              IF SQLCA.SQLCode<>0 THEN  bien=1
	  	 f_mensaje_proceso("Espere Por Favor ",x1,registros)
  
NEXT
END IF

destroy d
IF bien=0 THEN
  RETURN TRUE
ELSE
  RETURN FALSE
END IF
end function

event open;call super::open;istr_parametros.s_titulo_ventana="Toma de almacenes"
This.title=istr_parametros.s_titulo_ventana
dw_tomas.SetTransObject(SQLCA)

em_fecha.text=string(today())
Integer registros,x1
String     var_codigo,sel
String     var_texto,marca
integer bien,x2
datastore d
bien=0
x2=0

sel = "SELECT codigo,descripcion  "+&
				"  from almalmacen "+&
				" where almalmacen.empresa = '"+codigo_empresa+"'"+&
				" order by descripcion "
				
//d = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, d)
		
marca="S"
registros=d.retrieve(codigo_empresa)
If registros<>0 THEN
FOR x1= 1 To registros  
  var_codigo  = d.GetItemString(x1,"codigo")
  var_texto   = d.GetItemString(x1,"descripcion")
  uo_marca_lista.dw_marca.InsertRow(x1)
  uo_marca_lista.dw_marca.setitem(x1,"marca",marca)
  uo_marca_lista.dw_marca.setitem(x1,"codigo",var_codigo)
  uo_marca_lista.dw_marca.setitem(x1,"texto",var_texto)
NEXT
END IF
uo_marca_lista.st_titulo1.text="Almacen"
uo_marca_lista.st_titulo2.text="Texto"
x2=uo_marca_lista.dw_marca.RowCount()
dw_tomas.Retrieve(codigo_empresa)
dw_tomas.SetRowFocusIndicator(Hand!)		
dw_tomas.Retrieve(codigo_empresa)

ddlb_1.text = "Todos"

destroy d
end event

event ue_listar;dw_report  = report_almtoma
dw_report.SetTransObject(SQLCA)
String dalm,halm,codalm
if ddlb_1.text = "Todos" then
	dalm = "."
	halm = "Z"
else
	codalm = dw_tomas.GetItemString(dw_tomas.GetRow(),"almacen")
	dalm = codalm
	halm = codalm
End if
dw_report.retrieve(codigo_empresa,dw_tomas.GetItemDatetime(dw_tomas.GetRow(),"fecha_inv"),dalm,halm)
IF TRIM(filtro)<>"" THEN
 dw_report.SetFilter(filtro)
 dw_report.Filter()
END IF
CALL Super::ue_listar
end event

on w_int_almtoma.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.uo_marca_lista=create uo_marca_lista
this.st_1=create st_1
this.em_fecha=create em_fecha
this.pb_1=create pb_1
this.dw_tomas=create dw_tomas
this.report_almtoma=create report_almtoma
this.pb_2=create pb_2
this.pb_borrar=create pb_borrar
this.ddlb_1=create ddlb_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.uo_marca_lista
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.em_fecha
this.Control[iCurrent+5]=this.pb_1
this.Control[iCurrent+6]=this.dw_tomas
this.Control[iCurrent+7]=this.report_almtoma
this.Control[iCurrent+8]=this.pb_2
this.Control[iCurrent+9]=this.pb_borrar
this.Control[iCurrent+10]=this.ddlb_1
this.Control[iCurrent+11]=this.gb_1
end on

on w_int_almtoma.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.uo_marca_lista)
destroy(this.st_1)
destroy(this.em_fecha)
destroy(this.pb_1)
destroy(this.dw_tomas)
destroy(this.report_almtoma)
destroy(this.pb_2)
destroy(this.pb_borrar)
destroy(this.ddlb_1)
destroy(this.gb_1)
end on

event activate;call super::activate;w_int_almtoma = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_almtoma
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_almtoma
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_almtoma
integer y = 20
integer width = 2473
integer height = 116
end type

type cb_1 from u_boton within w_int_almtoma
integer x = 530
integer y = 180
integer width = 320
integer height = 84
integer taborder = 80
string text = "&Procesar"
end type

event clicked;call super::clicked;String mensaje
IF trim(em_fecha.text)="00/00/00" THEN
   mensaje="Introduzca la fecha"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   em_fecha.SetFocus()
   RETURN
END IF

integer registros

registros = uo_marca_lista.dw_marca.RowCount()
IF registros=0 THEN
   mensaje="Marcar algún almacen a procesar"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   uo_marca_lista.dw_marca.SetFocus()
   RETURN
END IF


IF Messagebox("Proceso Toma Almacen","¿Desea Procesar la Toma?",Question!,YesNo!,2)= 2 Then Return

// Comienza el proceso de toma de inventario

String var_codigo
Integer    x1,bien
bien=0

For x1 = 1 To registros
IF uo_marca_lista.dw_marca.GetItemString(x1,"marca")= "S" THEN
   var_codigo = uo_marca_lista.dw_marca.GetItemString(x1,"codigo")
   IF Trim(String(var_codigo))="" or IsNull(var_codigo) Then bien=1
	  //-------------------------------------//
	  // Congelamos la ubicacion por almacen //
	  //-------------------------------------//

		 titulo        =  Parent.title
		 longitud      =  len(trim(codigo_empresa))
		 criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
		 anyo          =  year(today())
		 longitud      =  len(trim(string(anyo)))
		 criterio[2]   =  trim(string(anyo))+space(20-longitud)
		 longitud      =  len(trim(var_codigo))
		 criterio[3]   =  trim(var_codigo)+space(20-longitud)
		 seleccion     =  criterio[1]+criterio[2]+criterio[3]
		 tabla         =  "almparam"
		 IF NOT f_bloquear(tabla,seleccion,titulo) THEN
			IF NOT toma_inv(codigo_empresa,var_codigo,Date(em_fecha.text)) THEN
				 bien = 1
			END IF
			f_desbloquear(tabla,seleccion,titulo)
			IF bien=0 THEN
				COMMIT Using SQLCA;
			ELSE
			  ROLLBACK Using SQLCA;
			  MessageBox("El almacen" + var_codigo,"NO se congela",Exclamation!, OK!,1)
			END IF
		  END IF
		 END IF
Next
dw_tomas.Retrieve(codigo_empresa)
f_activar_campo(em_fecha)

end event

type uo_marca_lista from u_marca_lista within w_int_almtoma
integer x = 1463
integer y = 304
integer width = 1367
integer height = 704
integer taborder = 50
boolean border = false
end type

on uo_marca_lista.destroy
call u_marca_lista::destroy
end on

type st_1 from statictext within w_int_almtoma
integer x = 5
integer y = 188
integer width = 197
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Fecha"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fecha from u_em_campo within w_int_almtoma
integer x = 215
integer y = 180
integer width = 306
integer taborder = 30
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
end type

type pb_1 from upb_salir within w_int_almtoma
integer x = 2697
integer y = 20
integer width = 119
integer height = 116
integer taborder = 0
end type

type dw_tomas from datawindow within w_int_almtoma
integer x = 9
integer y = 304
integer width = 1454
integer height = 1060
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_int_almtoma1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type report_almtoma from datawindow within w_int_almtoma
boolean visible = false
integer x = 1979
integer y = 620
integer width = 361
integer height = 156
integer taborder = 60
boolean bringtotop = true
string dataobject = "report_almtoma"
boolean livescroll = true
end type

type pb_2 from upb_imprimir within w_int_almtoma
integer x = 2464
integer y = 1200
integer width = 174
integer height = 152
integer taborder = 0
boolean originalsize = false
string picturename = "c:\bmp\impresra.bmp"
end type

event clicked;filtro=""
Integer registros,x1
String condicion,marca,Sel
DataStore d

sel = "SELECT codigo,descripcion  "+&
						"  from almalmacen "+&
						" where almalmacen.empresa = '"+codigo_empresa+"'"
				
//d = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, d)


registros= d.RowCount()
If registros<>0 THEN
 FOR x1= 1 To registros
  IF Trim(filtro)<>"" THEN filtro= filtro + " OR "
  marca=  uo_marca_lista.dw_marca.GetItemString(x1,"marca")
  IF marca="S" THEN
   condicion= "almacen = '" +  uo_marca_lista.dw_marca.GetItemString(x1,"codigo") + "'"
   filtro= filtro + condicion
  END IF
NEXT
END IF
Parent.TriggerEvent("ue_listar")

destroy d
end event

type pb_borrar from upb_papelera within w_int_almtoma
integer x = 1481
integer y = 1208
integer width = 183
integer height = 160
integer taborder = 20
end type

on clicked;call upb_papelera::clicked;
String var_almacen
Datetime var_fecha
Integer registro,opcion
registro = dw_tomas.GetRow()
If registro=0 Then Return
var_almacen  = dw_tomas.GetItemString(registro,"almacen")
var_fecha    = dw_tomas.GetItemDatetime(registro,"fecha_inv")
opcion= MessageBox("Proceso de borrado" ,"¿Desea borrar la toma seleccionada?",Question!,YesNo!,2)
If opcion=1 THEN
    Datetime xfecha
    String xempresa,xalmacen
    Integer xlinea
    SELECT   alminvent.empresa,alminvent.fecha_inv,alminvent.almacen,
             max(alminvent.linea)
    INTO :xempresa,:xfecha,:xalmacen,:xlinea  
    FROM alminvent  
   WHERE (alminvent.empresa = :codigo_empresa ) AND  
         (alminvent.fecha_inv = :var_fecha) AND  
         (alminvent.almacen = :var_almacen )   
   ORDER BY alminvent.empresa ASC,alminvent.fecha_inv ASC,   
         alminvent.almacen ASC;
   If IsNull(xlinea) Then xlinea=0
   IF xlinea<>0 Then
    MessageBox("No se puede Borrar" ,"Se han introducido lineas de inventario a esta toma",Exclamation!,Ok!,1)
    RETURN
   END IF
    DELETE FROM almtoma  
    WHERE (almtoma.empresa   = :codigo_empresa)
    AND   (almtoma.almacen   = :var_almacen)
    AND   (almtoma.fecha_inv = :var_fecha );
    IF SQLCA.SQLCode<>0 THEN
     ROLLBACK using SQLCA;
    ELSE
     COMMIT using SQLCA;
    END IF
    dw_tomas.Retrieve(codigo_empresa)
END IF
end on

type ddlb_1 from dropdownlistbox within w_int_almtoma
integer x = 1861
integer y = 1256
integer width = 594
integer height = 228
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean vscrollbar = true
string item[] = {"Todos","Seleccionado"}
end type

type gb_1 from groupbox within w_int_almtoma
integer x = 1833
integer y = 1160
integer width = 818
integer height = 204
integer taborder = 61
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

