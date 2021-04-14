$PBExportHeader$w_mant_comlinalb.srw
$PBExportComments$Introduccion Albaranes
forward
global type w_mant_comlinalb from w_int_con_empresa
end type
type cb_grabar from commandbutton within w_mant_comlinalb
end type
type cb_borrar from commandbutton within w_mant_comlinalb
end type
type pb_salir from upb_salir within w_mant_comlinalb
end type
type st_mprima from statictext within w_mant_comlinalb
end type
type st_cantidad from statictext within w_mant_comlinalb
end type
type st_precio from statictext within w_mant_comlinalb
end type
type st_f_entrega from statictext within w_mant_comlinalb
end type
type uo_prima from u_em_campo_2 within w_mant_comlinalb
end type
type uo_medida from u_em_campo_2 within w_mant_comlinalb
end type
type em_precio from u_em_campo within w_mant_comlinalb
end type
type em_fechaent from u_em_campo within w_mant_comlinalb
end type
type em_imp from editmask within w_mant_comlinalb
end type
type st_importe from statictext within w_mant_comlinalb
end type
type pb_c from picturebutton within w_mant_comlinalb
end type
type cb_anyadir_desde_pedidos from commandbutton within w_mant_comlinalb
end type
type em_alb from u_em_campo within w_mant_comlinalb
end type
type em_anyo2 from u_em_campo within w_mant_comlinalb
end type
type st_8 from statictext within w_mant_comlinalb
end type
type cb_sal from commandbutton within w_mant_comlinalb
end type
type pb_imp from upb_imprimir within w_mant_comlinalb
end type
type dw_listado from datawindow within w_mant_comlinalb
end type
type gb_7 from groupbox within w_mant_comlinalb
end type
type gb_5 from groupbox within w_mant_comlinalb
end type
type cb_insertar from commandbutton within w_mant_comlinalb
end type
type st_envase from statictext within w_mant_comlinalb
end type
type uo_envase from u_em_campo_2 within w_mant_comlinalb
end type
type st_descripcion from statictext within w_mant_comlinalb
end type
type em_descripcion from u_em_campo within w_mant_comlinalb
end type
type cb_procesar from commandbutton within w_mant_comlinalb
end type
type texto_ayuda from statictext within w_mant_comlinalb
end type
type pb_1 from picturebutton within w_mant_comlinalb
end type
type dw_2_aux from datawindow within w_mant_comlinalb
end type
type dw_2 from u_datawindow within w_mant_comlinalb
end type
type gb_2 from groupbox within w_mant_comlinalb
end type
type cb_1 from commandbutton within w_mant_comlinalb
end type
type em_cantidad from u_em_campo within w_mant_comlinalb
end type
type gb_3 from groupbox within w_mant_comlinalb
end type
type gb_1 from groupbox within w_mant_comlinalb
end type
type st_nombre_moneda1 from statictext within w_mant_comlinalb
end type
type st_nombre_moneda2 from statictext within w_mant_comlinalb
end type
type pb_borraralb from picturebutton within w_mant_comlinalb
end type
type cb_borraralb from commandbutton within w_mant_comlinalb
end type
type gb_89 from groupbox within w_mant_comlinalb
end type
type cb_newalb from commandbutton within w_mant_comlinalb
end type
type pb_salir_lineas_pedidos from picturebutton within w_mant_comlinalb
end type
type cb_salir_lineas_pedidos from u_boton within w_mant_comlinalb
end type
type pb_grabar_lineas_pedidos from picturebutton within w_mant_comlinalb
end type
type cb_grabar_lineas_pedidos from u_boton within w_mant_comlinalb
end type
type pb_actualizar_cabecera from picturebutton within w_mant_comlinalb
end type
type st_descuento from statictext within w_mant_comlinalb
end type
type st_seccion from statictext within w_mant_comlinalb
end type
type uo_seccion from u_em_campo_2 within w_mant_comlinalb
end type
type pb_seccion from picturebutton within w_mant_comlinalb
end type
type st_cuenta from statictext within w_mant_comlinalb
end type
type pb_cuenta from picturebutton within w_mant_comlinalb
end type
type uo_cuenta from u_em_campo within w_mant_comlinalb
end type
type st_nom from statictext within w_mant_comlinalb
end type
type dw_1 from datawindow within w_mant_comlinalb
end type
type dw_lineas_pedidos from datawindow within w_mant_comlinalb
end type
type em_descuento from u_em_campo within w_mant_comlinalb
end type
type cb_2 from commandbutton within w_mant_comlinalb
end type
type dw_existencias from datawindow within w_mant_comlinalb
end type
type p_cursor from picture within w_mant_comlinalb
end type
end forward

global type w_mant_comlinalb from w_int_con_empresa
integer x = 5
integer y = 48
integer width = 5001
integer height = 3156
string icon = "Application!"
cb_grabar cb_grabar
cb_borrar cb_borrar
pb_salir pb_salir
st_mprima st_mprima
st_cantidad st_cantidad
st_precio st_precio
st_f_entrega st_f_entrega
uo_prima uo_prima
uo_medida uo_medida
em_precio em_precio
em_fechaent em_fechaent
em_imp em_imp
st_importe st_importe
pb_c pb_c
cb_anyadir_desde_pedidos cb_anyadir_desde_pedidos
em_alb em_alb
em_anyo2 em_anyo2
st_8 st_8
cb_sal cb_sal
pb_imp pb_imp
dw_listado dw_listado
gb_7 gb_7
gb_5 gb_5
cb_insertar cb_insertar
st_envase st_envase
uo_envase uo_envase
st_descripcion st_descripcion
em_descripcion em_descripcion
cb_procesar cb_procesar
texto_ayuda texto_ayuda
pb_1 pb_1
dw_2_aux dw_2_aux
dw_2 dw_2
gb_2 gb_2
cb_1 cb_1
em_cantidad em_cantidad
gb_3 gb_3
gb_1 gb_1
st_nombre_moneda1 st_nombre_moneda1
st_nombre_moneda2 st_nombre_moneda2
pb_borraralb pb_borraralb
cb_borraralb cb_borraralb
gb_89 gb_89
cb_newalb cb_newalb
pb_salir_lineas_pedidos pb_salir_lineas_pedidos
cb_salir_lineas_pedidos cb_salir_lineas_pedidos
pb_grabar_lineas_pedidos pb_grabar_lineas_pedidos
cb_grabar_lineas_pedidos cb_grabar_lineas_pedidos
pb_actualizar_cabecera pb_actualizar_cabecera
st_descuento st_descuento
st_seccion st_seccion
uo_seccion uo_seccion
pb_seccion pb_seccion
st_cuenta st_cuenta
pb_cuenta pb_cuenta
uo_cuenta uo_cuenta
st_nom st_nom
dw_1 dw_1
dw_lineas_pedidos dw_lineas_pedidos
em_descuento em_descuento
cb_2 cb_2
dw_existencias dw_existencias
p_cursor p_cursor
end type
global w_mant_comlinalb w_mant_comlinalb

type variables
string numlinea
long numrow
str_linalbmov lin
boolean actualizar_cabecera

end variables

forward prototypes
public function string f_ultima_linea ()
public function boolean f_act_unimedida (string arg_mp, string arg_uni)
public function boolean f_restituir (long arg_lin, decimal arg_cat)
public function boolean f_existe_albaran ()
public function boolean f_act_precio_mprima (string arg_prove, string arg_mp, decimal arg_prec)
public subroutine f_procesar_entrada ()
public function boolean f_salida_almacen (string var_mp, string var_calidad, decimal var_cantidad, string var_envase, decimal var_precio)
public function boolean f_anyadir_lineas_pedidos ()
end prototypes

public function string f_ultima_linea ();string maxlinea
Select max(convert(int,comlinalb.linea)+1)
  Into   :maxlinea
  From   comlinalb
  Where comlinalb.empresa = :codigo_empresa
  and   comlinalb.anyo    = :em_anyo2.text
  and   comlinalb.albaran  = :em_alb.text;
  
  If  isnull(maxlinea) or sqlca.sqlcode=100 then
	  maxlinea="1"
  end if
  return maxlinea
end function

public function boolean f_act_unimedida (string arg_mp, string arg_uni);boolean bien
  UPDATE venmprima  
     SET tipo_unidad = :arg_uni  
   WHERE ( venmprima.empresa = :codigo_empresa ) AND  
         ( venmprima.codigo = :arg_mp )   ;
			
   if sqlca.sqlcode<>0 then
		messagebox("Error al actualizar unidad",sqlca.sqlerrtext)
		bien=true
	end if

return bien
	


end function

public function boolean f_restituir (long arg_lin, decimal arg_cat);long     i,existe_linea
string   linped,anyo_ped,anyo,albaran,linea
string   mprima,unidad,obs,ped,des,env,sec,subsec
datetime fecha
dec      cantidad,precio

i = arg_lin
anyo     = dw_1.getitemstring(i,"anyo")
albaran  = dw_1.getitemstring(i,"albaran")
linea    = dw_1.getitemstring(i,"linea")
anyo_ped = dw_1.getitemstring(i,"anyo_pedido")
ped      = dw_1.getitemstring(i,"pedido")
linped   = dw_1.getitemstring(i,"linea_pedido")
mprima   = dw_1.getitemstring(i,"mprima")
cantidad = dw_1.getitemnumber(i,"cantidad") - arg_cat
precio   = dw_1.getitemnumber(i,"precio")
fecha    = dw_1.getitemdatetime(i,"fecha_entrega")
unidad   = dw_1.getitemstring(i,"unidad_medida")
obs      = dw_1.getitemstring(i,"observaciones")
des      = dw_1.getitemstring(i,"descripcion")
env      = dw_1.getitemstring(i,"envase")
sec      = dw_1.getitemstring(i,"seccion")
subsec   = dw_1.getitemstring(i,"subseccion")

select count(*)
into   :existe_linea
from   comlinpedpro  
where  empresa = :codigo_empresa
and    anyo    = :anyo_ped
and    pedido  = :ped
and    linea   = :linped;

if isnull(existe_linea) then existe_linea = 0
if existe_linea = 0 then
	INSERT INTO comlinpedpro  
			( empresa,anyo,pedido,linea,mprima,cantidad,   
			  precio,fecha_entrega,unidad_medida,observaciones,libre,
			  seccion,subseccion,descripcion,envase )  
	VALUES ( :codigo_empresa,:anyo_ped,:ped,:linped,
			  :mprima,:cantidad,:precio,:fecha,:unidad,:obs,null,
			  :sec,:subsec,:des,:env)  ;
else
	update comlinpedpro  
	set    cantidad = cantidad + :cantidad
	where  empresa = :codigo_empresa
	and    anyo    = :anyo_ped
	and    pedido  = :ped
	and    linea   = :linped;	
end if

if sqlca.sqlcode<>0 then 
	messagebox("Atención","Se ha prodicido un error al restituir la linea del albaran.~n"+sqlca.sqlerrtext)
	return false
else
	return true
end if



end function

public function boolean f_existe_albaran ();Integer hay


SELECT COUNT(*) INTO :hay FROM comcabalb
WHERE comcabalb.empresa = :codigo_empresa
AND   comcabalb.anyo		= :em_anyo2.text
AND   comcabalb.albaran = :em_alb.text USING SQLCA;

IF IsNull(hay) THEN hay = 0

IF hay = 0 THEN
	RETURN FALSE
ELSE
	RETURN TRUE
END IF
end function

public function boolean f_act_precio_mprima (string arg_prove, string arg_mp, decimal arg_prec);boolean bien
datetime fechcomp
fechcomp=datetime(today())

	UPDATE comartpro
	SET precio = :arg_prec,
		 fecha  = :fechcomp
	WHERE ( comartpro.empresa   = :codigo_empresa ) AND
			( comartpro.proveedor = :arg_prove ) AND
			( comartpro.mprima    = :arg_mp )   ;
			
   if sqlca.sqlcode<>0 then
		messagebox("Error al actualizar precio",sqlca.sqlerrtext)
		bien=true
	end if

return bien
	


end function

public subroutine f_procesar_entrada ();//---------------------//
// Control Ubicaciones //
//---------------------//
Dec contador_nummov,contador_orden 
dec bien = 0
String antealmacen,var_anyo,var_alb
dec y1,longitudes
Date fecha
Dec numero,controles,x2,x1
Decimal{4} total_cantidad
string mensaje,nombre,campo,cur_mp,v_almacen,v_zona,var_linea
int v_fila,v_altura
Decimal{4} v_cantidad


//-----------------------------------------------------------------------
// Variables para cargar el cursor
//-----------------------------------------------------------------------
string cur_empresa,cur_almacen
dec cur_pedido,cur_linea,cur_anyo,cur_precio
decimal{4}  cur_existencias
string  cur_referencia,cur_ubicacion,cur_tipo_pallet
dec registros
String sel
DataStore dw_proceso 
dec grabado,salir
long contador

str_comlinubicahis ubihis
str_commovhis mov
str_comlinubica ubi
dw_1.Accepttext()
controles  = 0
contador = dw_1.Rowcount()

IF contador = 0 THEN
 MessageBox("No Puedo Procesar","No hay lineas de Albaran",Exclamation!, OK!,1)
 Return
END IF

//------------------------------------------------------------------------
// Valores fijos para todos los casos
//------------------------------------------------------------------------
ubihis.usuario       = nombre_usuario
mov.usuario          = nombre_usuario
ubihis.empresa       = codigo_empresa
ubihis.anyo          = year(today())
ubihis.f_alta        = DateTime(Today(),now())
ubihis.observaciones = "Entrada de albaran de compras de mp numero :"+em_alb.text
ubihis.tipomov       = "3"
ubihis.fecha         = dw_2.getitemDateTime(dw_2.getrow(),"fecha_alb")


IF Not f_bloquear_almacen_compras(w_mant_comlinalb.title) Then

	FOR x2 = 1 TO contador
		f_mensaje_proceso ("Procesando movimientos de almacen",contador,x2)
		if (dw_1.getitemstring(x2,"ubicado") <> "S") and (f_control_almacen(codigo_empresa,dw_1.GetItemstring(x2,"mprima")) = "S") and (dw_1.getitemstring(x2,"libre") = "B") then
			
			v_almacen    = f_almacen_mprima(codigo_empresa,dw_1.GetItemstring(x2,"mprima"))	
			if trim(v_almacen) = "" then
				bien = 1
				messagebox("Atención","Materia prima ["+dw_1.GetItemstring(x2,"mprima")+"] sin almacen de entrada.")				
			end if
			if v_almacen = '1' then
				v_zona = "A"
			else
				v_zona = "Z"
			end if
			v_fila       = 1
			v_altura     = 1
			v_cantidad   = dw_1.GetItemDecimal(x2,"cantidad")	
	
			// Contador de movimiento y orden de lineas de  ubicacion
	
	
			// Valor de controles funcionamiento
			ubihis.almacen       = v_almacen
			ubihis.mp		      = dw_1.GetItemstring(x2,"mprima")	
			ubihis.calidad       = "1"//
			ubihis.envase        = dw_1.GetItemstring(x2,"envase")
			
			if isnull(ubihis.calidad) then ubihis.calidad = ""
			ubihis.calidad = trim(ubihis.calidad)
			
			if isnull(ubihis.envase) then ubihis.envase = ""
			ubihis.envase = trim(ubihis.envase)
			
			SELECT venmprima.familia,
					 venmprima.tipo_unidad
			INTO   :ubihis.familia,
					 :ubihis.tipo_unidad
			FROM   venmprima
			WHERE  venmprima.empresa = :ubihis.empresa
			AND    venmprima.codigo  = :ubihis.mp ;
				
			IF SQLCA.SQLCode<>0 THEN 
				bien=1
				MESSAGEBOX ("F_PROCESAR_ENTRADA","ERROR NUMERO 1")
			END IF
			mov.envase     = 	ubihis.envase
			ubi.envase     =  ubihis.envase
			ubi.empresa    =  ubihis.empresa
			ubi.almacen    =  ubihis.almacen
			ubi.mp		   =  ubihis.mp
			ubi.familia    =  ubihis.familia
			ubi.calidad    =  ubihis.calidad
			ubi.tipo_unidad=  ubihis.tipo_unidad
			ubi.f_alta     =  Datetime(today(),now())
			// Valor movimiento historico
			mov.empresa    =  ubihis.empresa
			mov.almacen    =  ubihis.almacen
			mov.mp		   =  ubihis.mp
			mov.familia    =  ubihis.familia
			mov.calidad    =  ubihis.calidad
			mov.tipo_unidad=  ubihis.tipo_unidad
			mov.f_alta     =  DateTime(Today(),now())
			fecha          =  Today() 
			mov.anyo       =  year(fecha)
			//****
			mov.origen     = "1"
			mov.fechmov    = ubihis.fecha
			mov.tipomov    = ubihis.tipomov
			mov.cantidade  = v_cantidad 
			mov.cantidads  = 0
			mov.precio     = dw_1.object.precio[x2]
			ubi.precio     = mov.precio
			ubihis.precio  = mov.precio
			mov.codtercero = dw_2.getitemstring(dw_2.getrow(),"proveedor")
							
			mov.numdoc        = em_alb.text
			mov.situacion     = "N"
			mov.observaciones = ubihis.observaciones
			// Variable utilizada para montaje observaciones en lineas de ubicacion
			  String var_observaciones
			//-------------------------------------------------------------------
			contador_nummov= f_comparam_nummov(codigo_empresa,Year(fecha))
			contador_orden = f_comparam_numorden(codigo_empresa,Year(fecha))
			mov.nummov     = contador_nummov
			ubihis.nummov  = contador_nummov
			ubihis.orden   = contador_orden			
			
			ubihis.zona       = v_zona
			ubihis.fila       = v_fila
			ubihis.altura     = v_altura
			IF IsNull(ubihis.altura) Then ubihis.altura = 0
			ubihis.cantidade  = dw_1.GetItemDecimal(x2,"cantidad")	
			ubihis.orden      = contador_orden
			ubihis.nummov     = contador_nummov
			ubihis.observaciones  = mov.observaciones
			ubihis.f_alta     = DateTime(Today(),now())
			ubihis.usuario    = nombre_usuario
			ubihis.ubicacion  = f_componer_ubicacion(ubihis.almacen,ubihis.zona,&
																		 ubihis.fila,ubihis.altura)
			ubihis.cantidads    = 0
			ubi.zona            = ubihis.zona
			ubi.fila            = ubihis.fila
			ubi.altura          = ubihis.altura
			ubi.existencias     = ubihis.cantidade
			ubi.ubicacion       = ubihis.ubicacion
			//------------------------------------------------------------------
			// Inserto en el historico de lineas de ubicacion por movimiento
			//------------------------------------------------------------------
			ubihis.observaciones =  ubihis.observaciones  
			IF Not f_insert_comlinubicahis(ubihis) Then  
				bien=1
			  	MESSAGEBOX ("F_PROCESAR_ENTRADA","ERROR NUMERO 2")
			END IF
			//----------------------------------------------------------
			// Busco si hay linea este articulo sin reservar
			//---------------------------------------------------------
				  
				 
			Sel = " SELECT   linea,existencias,precio  " + &
					" FROM     comlinubica  " + &
					" WHERE    comlinubica.empresa     = '"+ codigo_empresa  + "'" +&
					" AND      comlinubica.ubicacion   = '"+ ubi.ubicacion + "'" +&
					" AND      comlinubica.mp          = '"+ ubi.mp + "'" +&
					" AND      comlinubica.calidad     = '"+ ubi.calidad + "'"+&
					" AND 	  comlinubica.envase      = '"+ ubi.envase +"' "+&
					" AND      comlinubica.tipo_unidad = '"+ ubi.tipo_unidad + "' "
					//" AND      comlinubica.precio     = "+string(ubi.precio)+" "
			
			//dw_proceso = f_cargar_cursor2(sel)
			f_cargar_cursor_nuevo(sel, dw_proceso)
			registros  = dw_proceso.RowCount()
	
			grabado = 0
			salir   = 0
			IF registros <> 0 THEN
				FOR x1 = 1 To registros
					//cur_precio = dw_proceso.object.precio[x1]
					//if (cur_precio = ubi.precio) and (grabado = 0) then
						cur_empresa       = codigo_empresa
						cur_almacen       = f_almacen_ubicacion(ubi.ubicacion)
						cur_ubicacion     = ubi.ubicacion
						cur_mp    			= ubi.mp		
						cur_existencias   = dw_proceso.GetItemNumber(x1,"existencias")		
						cur_linea         = dw_proceso.GetItemNumber(x1,"linea")
						grabado           = 1
						ubi.existencias   = ubi.existencias + cur_existencias
						UPDATE comlinubica  
						SET existencias   = :ubi.existencias,   
							 f_alta        = :ubi.f_alta
						WHERE  comlinubica.empresa   = :ubi.empresa 
						AND    comlinubica.ubicacion = :ubi.ubicacion 
						AND    comlinubica.linea     = :cur_linea  USING SQLCA;
						IF SQLCA.SQLCode<>0 THEN 
							bien=1
							MESSAGEBOX ("F_PROCESAR_ENTRADA","ERROR NUMERO 3")
						END IF
						EXIT
					//end if
				NEXT
			END IF
			IF grabado = 0 THEN
				cur_linea = 0
				SELECT  max(comlinubica.linea)
				INTO    :cur_linea 
				FROM    comlinubica  
				WHERE   comlinubica.empresa   = :ubi.empresa 
				AND     comlinubica.ubicacion = :ubi.ubicacion;
				IF IsNull(cur_linea) or trim(string(cur_linea))="" THEN
					cur_linea = 0 
				END IF
				cur_linea=cur_linea+1
				ubi.linea=cur_linea
				SetNull(ubi.observaciones)
				IF NOT f_insert_comlinubica(ubi) Then 
					bien=1
					MESSAGEBOX ("F_PROCESAR_ENTRADA","ERROR NUMERO 4")
				END IF
			end if
			
	
			// el contador incrementa uno para cada linea
			contador_orden = contador_orden + 1
		  
			// Grabar el movimiento en el historico por el total de existencias
			IF NOT f_insert_commovhis(mov) Then
				MessageBox("Error en proceso","Grabando commovhis",Exclamation!, OK!,1)
				bien=1
			END IF
			IF NOT f_actualiza_nummov_compras(mov.empresa,Year(fecha),mov.nummov) THEN
				MESSAGEBOX ("F_PROCESAR_ENTRADA","ERROR NUMERO 5")
				bien=1
			END IF
			IF NOT f_actualiza_numorden_compras(ubihis.empresa,Year(fecha),ubihis.orden) THEN
				bien=1
				MESSAGEBOX ("F_PROCESAR_ENTRADA","ERROR NUMERO 6")
			END IF
			var_anyo        = em_anyo2.text
			var_alb         = em_alb.text
			var_linea       = dw_1.getitemstring(x2,"linea")
			
			UPDATE comlinalb  SET 
					 ubicado			= "S"
			Where empresa = :codigo_empresa
			and anyo = :var_anyo
			and albaran = :var_alb
			and linea   = :var_linea;		
		
			IF sqlca.sqlcode <> 0 THEN 
				messagebox("Error al modificar la linea",sqlca.sqlerrtext)
				bien = 1
			end if
			
		end if  
	NEXT
	CHOOSE CASE bien
	CASE 1
   	ROLLBACK USING SQLCA;
     	MessageBox("Fin de proceso","Error en proceso no se actualiza",Exclamation!, OK!,1)
	CASE 0
		commit;
		messagebox ("OK","Operación realizada correctamente")
   CASE ELSE
     	ROLLBACK USING SQLCA;
     	MessageBox("Fin de proceso","Error en proceso no se actualiza",Exclamation!, OK!,1)
	END CHOOSE
	f_desbloquear_almacen_compras(w_mant_comlinalb.title)

END IF

destroy dw_proceso
end subroutine

public function boolean f_salida_almacen (string var_mp, string var_calidad, decimal var_cantidad, string var_envase, decimal var_precio);
//ubihis.zona          = "A"
//ubihis.zona 			= dw_existencias.object.zona[dw_existencias.Getrow()]
//ubihis.fila          = 1
//ubihis.fila 			= dw_existencias.object.fila[dw_existencias.Getrow()]
//ubihis.altura        = 1
//ubihis.altura 			= dw_existencias.object.altura[dw_existencias.Getrow()]



//---------------------//
// Control Ubicaciones //
//---------------------//
Dec contador_nummov,contador_orden 
dec bien = 0
String antealmacen,var_anyo,var_alb
dec y1,longitudes
Date fecha
Dec numero,controles,x2,x1
Decimal{4} total_cantidad
string mensaje,nombre,campo,cur_mp,v_almacen,v_zona,var_linea
int v_fila,v_altura
Decimal{4} v_cantidad


//-----------------------------------------------------------------------
// Variables para cargar el cursor
//-----------------------------------------------------------------------
string cur_empresa,cur_almacen
dec cur_pedido,cur_linea,cur_anyo,cur_precio
decimal{4}  cur_existencias
string  cur_referencia,cur_ubicacion,cur_tipo_pallet
dec registros
String sel
DataStore dw_proceso 
dec grabado,salir
long contador

str_comlinubicahis ubihis
str_commovhis mov
str_comlinubica ubi
dw_1.Accepttext()
controles  = 0
contador = dw_1.Rowcount()

//------------------------------------------------------------------------
// Valores fijos para todos los casos
//------------------------------------------------------------------------
ubihis.usuario       = nombre_usuario
mov.usuario          = nombre_usuario
ubihis.empresa       = codigo_empresa
ubihis.anyo          = year(today())
ubihis.f_alta        = DateTime(Today(),now())
ubihis.observaciones = "Entrada de albaran de compras de mp numero :"+em_alb.text
ubihis.tipomov       = "104"
ubihis.fecha         = dw_2.getitemDateTime(dw_2.getrow(),"fecha_alb")

x2 = dw_1.getrow()
if (dw_1.getitemstring(x2,"ubicado") = "S") &
	and (f_control_almacen(codigo_empresa,dw_1.GetItemstring(x2,"mprima")) = "S") &
	and (dw_1.getitemstring(x2,"libre") = "B") then

	v_cantidad   = dw_1.GetItemDecimal(x2,"cantidad")	
	v_almacen = dw_existencias.object.almacen[dw_existencias.Getrow()]
	v_zona = dw_existencias.object.zona[dw_existencias.Getrow()]
	v_fila = dw_existencias.object.fila[dw_existencias.Getrow()]
	v_altura = dw_existencias.object.altura[dw_existencias.Getrow()]

	// Valor de controles funcionamiento
	ubihis.almacen       = v_almacen
	ubihis.mp		      = dw_1.GetItemstring(x2,"mprima")	
	ubihis.calidad       = "1"//
	ubihis.envase        = dw_1.GetItemstring(x2,"envase")
	
	if isnull(ubihis.calidad) then ubihis.calidad = ""
	ubihis.calidad = trim(ubihis.calidad)
	
	if isnull(ubihis.envase) then ubihis.envase = ""
	ubihis.envase = trim(ubihis.envase)
	
	SELECT venmprima.familia,
			 venmprima.tipo_unidad
	INTO   :ubihis.familia,
			 :ubihis.tipo_unidad
	FROM   venmprima
	WHERE  venmprima.empresa = :ubihis.empresa
	AND    venmprima.codigo  = :ubihis.mp ;
		
	IF SQLCA.SQLCode<>0 THEN 
		bien=1
		MESSAGEBOX ("F_PROCESAR_ENTRADA","ERROR NUMERO 1")
	END IF
	mov.envase     = 	ubihis.envase
	ubi.envase     =  ubihis.envase
	ubi.empresa    =  ubihis.empresa
	ubi.almacen    =  ubihis.almacen
	ubi.mp		   =  ubihis.mp
	ubi.familia    =  ubihis.familia
	ubi.calidad    =  ubihis.calidad
	ubi.tipo_unidad=  ubihis.tipo_unidad
	ubi.f_alta     =  Datetime(today(),now())
	// Valor movimiento historico
	mov.empresa    =  ubihis.empresa
	mov.almacen    =  ubihis.almacen
	mov.mp		   =  ubihis.mp
	mov.familia    =  ubihis.familia
	mov.calidad    =  ubihis.calidad
	mov.tipo_unidad=  ubihis.tipo_unidad
	mov.f_alta     =  DateTime(Today(),now())
	fecha          =  Today() 
	mov.anyo       =  year(fecha)
	//****
	mov.origen     = "1"
	mov.fechmov    = ubihis.fecha
	mov.tipomov    = ubihis.tipomov
	mov.cantidade  = 0 
	mov.cantidads  = v_cantidad
	mov.precio     = dw_1.object.precio[x2]
	ubi.precio     = mov.precio
	ubihis.precio  = mov.precio
	mov.codtercero = dw_2.getitemstring(dw_2.getrow(),"proveedor")
					
	mov.numdoc        = em_alb.text
	mov.situacion     = "N"
	mov.observaciones = ubihis.observaciones
	// Variable utilizada para montaje observaciones en lineas de ubicacion
	  String var_observaciones
	//-------------------------------------------------------------------
	contador_nummov= f_comparam_nummov(codigo_empresa,Year(fecha))
	contador_orden = f_comparam_numorden(codigo_empresa,Year(fecha))
	mov.nummov     = contador_nummov
	ubihis.nummov  = contador_nummov
	ubihis.orden   = contador_orden			
	
	ubihis.zona       = v_zona
	ubihis.fila       = v_fila
	ubihis.altura     = v_altura
	IF IsNull(ubihis.altura) Then ubihis.altura = 0
	// David 03-06-2011. En la salida no debe introducir ningún valor en cantidade. Le pongo 0 "a piñon".
//	ubihis.cantidade  = dw_1.GetItemDecimal(x2,"cantidad")	
	ubihis.cantidade  = 0
	
	ubihis.orden      = contador_orden
	ubihis.nummov     = contador_nummov
	ubihis.observaciones  = mov.observaciones
	ubihis.f_alta     = DateTime(Today(),now())
	ubihis.usuario    = nombre_usuario
	ubihis.ubicacion  = f_componer_ubicacion(ubihis.almacen,ubihis.zona,&
																 ubihis.fila,ubihis.altura)
	ubihis.cantidads    = mov.cantidads
	ubi.zona            = ubihis.zona
	ubi.fila            = ubihis.fila
	ubi.altura          = ubihis.altura
	ubi.existencias     = ubihis.cantidads
	ubi.ubicacion       = ubihis.ubicacion
	//------------------------------------------------------------------
	// Inserto en el historico de lineas de ubicacion por movimiento
	//------------------------------------------------------------------
	ubihis.observaciones =  ubihis.observaciones  
	IF Not f_insert_comlinubicahis(ubihis) Then  
		bien=1
		MESSAGEBOX ("F_PROCESAR_ENTRADA","ERROR NUMERO 2")
	END IF
	//----------------------------------------------------------
	// Busco si hay linea este articulo sin reservar
	//---------------------------------------------------------
		  
		 
	Sel = " SELECT   linea,existencias,precio  " + &
			" FROM     comlinubica  " + &
			" WHERE    comlinubica.empresa     = '"+ codigo_empresa  + "'" +&
			" AND      comlinubica.ubicacion   = '"+ ubi.ubicacion + "'" +&
			" AND      comlinubica.mp          = '"+ ubi.mp + "'" +&
			" AND      comlinubica.calidad     = '"+ ubi.calidad + "'"+&
			" AND 	  comlinubica.envase      = '"+ ubi.envase +"' "+&
			" AND      comlinubica.tipo_unidad = '"+ ubi.tipo_unidad + "' "

	f_cargar_cursor_nuevo(sel, dw_proceso)
	registros  = dw_proceso.RowCount()

	grabado = 0
	salir   = 0
	IF registros <> 0 THEN
		FOR x1 = 1 To registros
			cur_empresa       = codigo_empresa
			cur_almacen       = f_almacen_ubicacion(ubi.ubicacion)
			cur_ubicacion     = ubi.ubicacion
			cur_mp    			= ubi.mp		
			cur_existencias   = dw_proceso.GetItemNumber(x1,"existencias")		
			cur_linea         = dw_proceso.GetItemNumber(x1,"linea")
			grabado           = 1
			ubi.existencias   = cur_existencias - 	ubi.existencias 	
			UPDATE comlinubica  
			SET existencias   = :ubi.existencias,   
				 f_alta        = :ubi.f_alta
			WHERE  comlinubica.empresa   = :ubi.empresa 
			AND    comlinubica.ubicacion = :ubi.ubicacion 
			AND    comlinubica.linea     = :cur_linea  USING SQLCA;
			IF SQLCA.SQLCode<>0 THEN 
				bien=1
				MESSAGEBOX ("F_PROCESAR_SLAIDA","ERROR NUMERO 3")
			END IF
			EXIT
		NEXT
	END IF
	IF grabado = 0 THEN
		cur_linea = 0
		SELECT  max(comlinubica.linea)
		INTO    :cur_linea 
		FROM    comlinubica  
		WHERE   comlinubica.empresa   = :ubi.empresa 
		AND     comlinubica.ubicacion = :ubi.ubicacion;
		IF IsNull(cur_linea) or trim(string(cur_linea))="" THEN
			cur_linea = 0 
		END IF
		cur_linea=cur_linea+1
		ubi.linea=cur_linea
		SetNull(ubi.observaciones)
		IF NOT f_insert_comlinubica(ubi) Then 
			bien=1
			MESSAGEBOX ("F_PROCESAR_ENTRADA","ERROR NUMERO 4")
		END IF
	end if
	

	// el contador incrementa uno para cada linea
	contador_orden = contador_orden + 1
  
	// Grabar el movimiento en el historico por el total de existencias
	IF NOT f_insert_commovhis(mov) Then
		MessageBox("Error en proceso","Grabando commovhis",Exclamation!, OK!,1)
		bien=1
	END IF
	IF NOT f_actualiza_nummov_compras(mov.empresa,Year(fecha),mov.nummov) THEN
		MESSAGEBOX ("F_PROCESAR_ENTRADA","ERROR NUMERO 5")
		bien=1
	END IF
	IF NOT f_actualiza_numorden_compras(ubihis.empresa,Year(fecha),ubihis.orden) THEN
		bien=1
		MESSAGEBOX ("F_PROCESAR_ENTRADA","ERROR NUMERO 6")
	END IF
	var_anyo        = em_anyo2.text
	var_alb         = em_alb.text
	var_linea       = dw_1.getitemstring(x2,"linea")
	
	UPDATE comlinalb  SET 
			 ubicado			= "S"
	Where empresa = :codigo_empresa
	and anyo = :var_anyo
	and albaran = :var_alb
	and linea   = :var_linea;		

	IF sqlca.sqlcode <> 0 THEN 
		messagebox("Error al modificar la linea",sqlca.sqlerrtext)
		bien = 1
	end if
	
end if  
CHOOSE CASE bien
CASE 1
//	ROLLBACK USING SQLCA;
	MessageBox("Fin de proceso","Error en proceso no se actualiza",Exclamation!, OK!,1)
	RETURN FALSE
CASE 0
//	COMMIT USING sqlca;
	messagebox ("OK","Operación realizada correctamente")
	RETURN TRUE

CASE ELSE
//	ROLLBACK USING SQLCA;
	MessageBox("Fin de proceso","Error en proceso no se actualiza",Exclamation!, OK!,1)
	RETURN FALSE
	
END CHOOSE

destroy dw_proceso

end function

public function boolean f_anyadir_lineas_pedidos ();long     indice,total,lineas_anyadidas,decimales_precios_albaran,decimales_proveedor,lineas_pedido
boolean  bien = true
string   moneda_pedido,moneda_albaran,moneda_proveedor,proveedor
dec      cambio_moneda_pedido,cambio_moneda_albaran,cantidad_pendiente
datetime fecha_pedido
str_comlinalb    comlinalb

if dw_2.rowcount() = 1 then
	comlinalb.empresa = codigo_empresa
	comlinalb.anyo    = string(dec(em_anyo2.text),"####")
	comlinalb.albaran = string(dec(em_alb.text),"######")
	
	proveedor                 = dw_2.object.proveedor[1]
	moneda_albaran            = dw_2.object.moneda[1]
	decimales_precios_albaran = dw_2.object.decimales_precios[1]
	cambio_moneda_albaran     = dw_2.object.cambio[1]
	
	if isnull(moneda_albaran) then moneda_albaran = ""
	if isnull(decimales_precios_albaran) then decimales_precios_albaran = 0
	if isnull(cambio_moneda_albaran) then cambio_moneda_albaran = 0
		
	select moneda,					decimales_precios
	into   :moneda_proveedor,  :decimales_proveedor
	from   comproveedores
	where  empresa = :codigo_empresa
	and    codigo  = :proveedor;
	
	if sqlca.sqlcode <> 0 then
		bien = false
		messagebox("Atención!!","Se ha producido un error al comprobar los datos del proveedor.")
	end if
	
	if trim(moneda_albaran) = "" then
		moneda_albaran            = moneda_proveedor
		decimales_precios_albaran = decimales_proveedor
		cambio_moneda_albaran     = f_cambio_moneda(moneda_proveedor)
		
		dw_2.object.moneda[1]            = moneda_albaran
		dw_2.object.decimales_precios[1] = decimales_precios_albaran
		dw_2.object.cambio[1]            = cambio_moneda_albaran
	else
		if cambio_moneda_albaran = 0 then
			cambio_moneda_albaran = f_cambio_moneda(moneda_albaran)
			dw_2.object.cambio[1] = cambio_moneda_albaran
		end if		
	end if
	
	lineas_anyadidas = 0
	
	total = dw_lineas_pedidos.rowcount()
	
	for indice = 1 to total		
		if dw_lineas_pedidos.object.recibido[indice] = "S" then
			moneda_pedido = dw_lineas_pedidos.object.comcabpedpro_moneda[indice]
			
			if isnull(moneda_pedido) then moneda_pedido = ""
			if trim(moneda_pedido) = "" then moneda_pedido = moneda_albaran						
			
			lineas_anyadidas ++
			//comlinalb.linea se calcula en f_insert_comlinalb()
			comlinalb.mprima        = dw_lineas_pedidos.object.mprima[indice]
			comlinalb.cantidad      = dw_lineas_pedidos.object.comlinpedpro_cantidad_recibida[indice]
			comlinalb.precio        = dw_lineas_pedidos.object.precio[indice]
			
			if moneda_pedido <> moneda_albaran then
				cambio_moneda_pedido = dw_lineas_pedidos.object.comcabpedpro_cambio[indice]
				if isnull(cambio_moneda_pedido) then cambio_moneda_pedido = 0
				if cambio_moneda_pedido = 0 then
					cambio_moneda_pedido = f_cambio_moneda(moneda_pedido)
				end if
				if cambio_moneda_pedido <> 0 then
					comlinalb.precio = (comlinalb.precio / cambio_moneda_pedido) * cambio_moneda_albaran
				end if				
			end if
			
			comlinalb.precio        = round(comlinalb.precio,decimales_precios_albaran)
			comlinalb.descuento     = dw_lineas_pedidos.object.comlinpedpro_descuento[indice]
			comlinalb.fecha_entrega = dw_lineas_pedidos.object.fecha_entrega[indice]
			comlinalb.unidad_medida = dw_lineas_pedidos.object.unidad_medida[indice]
			comlinalb.pedido        = dw_lineas_pedidos.object.pedido[indice]
			comlinalb.linea_pedido  = dw_lineas_pedidos.object.linea[indice]
			comlinalb.situacion     = "N"
			comlinalb.observaciones = dw_lineas_pedidos.object.observaciones[indice]
			comlinalb.libre         = "N"
			comlinalb.anyo_pedido   = dw_lineas_pedidos.object.anyo[indice]
			setnull(comlinalb.fecha_control)
			comlinalb.seccion       = dw_lineas_pedidos.object.comlinpedpro_seccion[indice]
			comlinalb.subseccion    = ""
			comlinalb.descripcion   = dw_lineas_pedidos.object.descripcion[indice]
			comlinalb.envase        = dw_lineas_pedidos.object.envase[indice]
			comlinalb.cuenta        = f_cuenta_mprima(codigo_empresa,comlinalb.mprima)
			comlinalb.importe       = dec(string(comlinalb.precio * comlinalb.cantidad,f_mascara_moneda(moneda_albaran)))
			
			if comlinalb.descuento > 0 then
				comlinalb.importe = comlinalb.importe -((comlinalb.importe / 100) * comlinalb.descuento)
				comlinalb.importe = dec(string(comlinalb.importe,f_mascara_moneda(moneda_albaran)))
			end if
			
			comlinalb.importe       = dec(string(comlinalb.importe,f_mascara_moneda(moneda_albaran)))
			comlinalb.automatico    = "N"
			comlinalb.ubicado       = "N"
			comlinalb.pedido_por    = dw_lineas_pedidos.object.comcabpedpro_pedidopor[indice]
			comlinalb.fecha_pedido  = dw_lineas_pedidos.object.comcabpedpro_fecha_pedido[indice]
			
			if not(f_insert_comlinalb(comlinalb)) then
				bien = false
				messagebox("Atención","Error al insertar la linea del albarán.")
			else
				cantidad_pendiente = dw_lineas_pedidos.object.cantidad[indice] - comlinalb.cantidad
				
				if cantidad_pendiente < 0 then
					cantidad_pendiente = 0
				end if
				
				if cantidad_pendiente = 0 then
					delete comlinpedpro
					where  empresa = :codigo_empresa
					and    anyo    = :comlinalb.anyo_pedido
					and    pedido  = :comlinalb.pedido
					and    linea   = :comlinalb.linea_pedido;
					
					if sqlca.sqlcode <> 0 then
						bien = false
						messagebox("Atención","Error al borrar la linea del pedido.")
					else
						lineas_pedido = 0
						
						select count(*)
						into   :lineas_pedido
						from   comcabpedpro
						where  empresa = :codigo_empresa
						and    anyo    = :comlinalb.anyo_pedido
						and    pedido  = :comlinalb.pedido;
						
						if isnull(lineas_pedido) then lineas_pedido = 0
						
						if lineas_pedido = 0 then
							delete comcabpedpro
							where  empresa = :codigo_empresa
							and    anyo    = :comlinalb.anyo_pedido
							and    pedido  = :comlinalb.pedido;
							if sqlca.sqlcode <> 0 then
								bien = false
								messagebox("Atención","Error al borrar la cabecera del pedido.")
							end if
						end if
					end if
				else					
					update comlinpedpro
					set    cantidad = :cantidad_pendiente
					where  empresa = :codigo_empresa
					and    anyo    = :comlinalb.anyo_pedido
					and    pedido  = :comlinalb.pedido
					and    linea   = :comlinalb.linea_pedido;
					
					if sqlca.sqlcode <> 0 then
						bien = false
						messagebox("Atención","Error al modificar la linea del pedido.")
					end if					
				end if
			end if		
		end if
	next
	
	if lineas_anyadidas > 0 and actualizar_cabecera and bien then
		if dw_2.update() = -1 then
			messagebox("Error!!","Se ha producido un error al actualizar la cabecera.~n"+sqlca.sqlerrtext)
			bien = false
		else
			actualizar_cabecera = false
		end if
	end if
else
	bien = false
	messagebox("Atención","No hay cabecera de albarán.")
end if

return bien
end function

on w_mant_comlinalb.create
int iCurrent
call super::create
this.cb_grabar=create cb_grabar
this.cb_borrar=create cb_borrar
this.pb_salir=create pb_salir
this.st_mprima=create st_mprima
this.st_cantidad=create st_cantidad
this.st_precio=create st_precio
this.st_f_entrega=create st_f_entrega
this.uo_prima=create uo_prima
this.uo_medida=create uo_medida
this.em_precio=create em_precio
this.em_fechaent=create em_fechaent
this.em_imp=create em_imp
this.st_importe=create st_importe
this.pb_c=create pb_c
this.cb_anyadir_desde_pedidos=create cb_anyadir_desde_pedidos
this.em_alb=create em_alb
this.em_anyo2=create em_anyo2
this.st_8=create st_8
this.cb_sal=create cb_sal
this.pb_imp=create pb_imp
this.dw_listado=create dw_listado
this.gb_7=create gb_7
this.gb_5=create gb_5
this.cb_insertar=create cb_insertar
this.st_envase=create st_envase
this.uo_envase=create uo_envase
this.st_descripcion=create st_descripcion
this.em_descripcion=create em_descripcion
this.cb_procesar=create cb_procesar
this.texto_ayuda=create texto_ayuda
this.pb_1=create pb_1
this.dw_2_aux=create dw_2_aux
this.dw_2=create dw_2
this.gb_2=create gb_2
this.cb_1=create cb_1
this.em_cantidad=create em_cantidad
this.gb_3=create gb_3
this.gb_1=create gb_1
this.st_nombre_moneda1=create st_nombre_moneda1
this.st_nombre_moneda2=create st_nombre_moneda2
this.pb_borraralb=create pb_borraralb
this.cb_borraralb=create cb_borraralb
this.gb_89=create gb_89
this.cb_newalb=create cb_newalb
this.pb_salir_lineas_pedidos=create pb_salir_lineas_pedidos
this.cb_salir_lineas_pedidos=create cb_salir_lineas_pedidos
this.pb_grabar_lineas_pedidos=create pb_grabar_lineas_pedidos
this.cb_grabar_lineas_pedidos=create cb_grabar_lineas_pedidos
this.pb_actualizar_cabecera=create pb_actualizar_cabecera
this.st_descuento=create st_descuento
this.st_seccion=create st_seccion
this.uo_seccion=create uo_seccion
this.pb_seccion=create pb_seccion
this.st_cuenta=create st_cuenta
this.pb_cuenta=create pb_cuenta
this.uo_cuenta=create uo_cuenta
this.st_nom=create st_nom
this.dw_1=create dw_1
this.dw_lineas_pedidos=create dw_lineas_pedidos
this.em_descuento=create em_descuento
this.cb_2=create cb_2
this.dw_existencias=create dw_existencias
this.p_cursor=create p_cursor
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_grabar
this.Control[iCurrent+2]=this.cb_borrar
this.Control[iCurrent+3]=this.pb_salir
this.Control[iCurrent+4]=this.st_mprima
this.Control[iCurrent+5]=this.st_cantidad
this.Control[iCurrent+6]=this.st_precio
this.Control[iCurrent+7]=this.st_f_entrega
this.Control[iCurrent+8]=this.uo_prima
this.Control[iCurrent+9]=this.uo_medida
this.Control[iCurrent+10]=this.em_precio
this.Control[iCurrent+11]=this.em_fechaent
this.Control[iCurrent+12]=this.em_imp
this.Control[iCurrent+13]=this.st_importe
this.Control[iCurrent+14]=this.pb_c
this.Control[iCurrent+15]=this.cb_anyadir_desde_pedidos
this.Control[iCurrent+16]=this.em_alb
this.Control[iCurrent+17]=this.em_anyo2
this.Control[iCurrent+18]=this.st_8
this.Control[iCurrent+19]=this.cb_sal
this.Control[iCurrent+20]=this.pb_imp
this.Control[iCurrent+21]=this.dw_listado
this.Control[iCurrent+22]=this.gb_7
this.Control[iCurrent+23]=this.gb_5
this.Control[iCurrent+24]=this.cb_insertar
this.Control[iCurrent+25]=this.st_envase
this.Control[iCurrent+26]=this.uo_envase
this.Control[iCurrent+27]=this.st_descripcion
this.Control[iCurrent+28]=this.em_descripcion
this.Control[iCurrent+29]=this.cb_procesar
this.Control[iCurrent+30]=this.texto_ayuda
this.Control[iCurrent+31]=this.pb_1
this.Control[iCurrent+32]=this.dw_2_aux
this.Control[iCurrent+33]=this.dw_2
this.Control[iCurrent+34]=this.gb_2
this.Control[iCurrent+35]=this.cb_1
this.Control[iCurrent+36]=this.em_cantidad
this.Control[iCurrent+37]=this.gb_3
this.Control[iCurrent+38]=this.gb_1
this.Control[iCurrent+39]=this.st_nombre_moneda1
this.Control[iCurrent+40]=this.st_nombre_moneda2
this.Control[iCurrent+41]=this.pb_borraralb
this.Control[iCurrent+42]=this.cb_borraralb
this.Control[iCurrent+43]=this.gb_89
this.Control[iCurrent+44]=this.cb_newalb
this.Control[iCurrent+45]=this.pb_salir_lineas_pedidos
this.Control[iCurrent+46]=this.cb_salir_lineas_pedidos
this.Control[iCurrent+47]=this.pb_grabar_lineas_pedidos
this.Control[iCurrent+48]=this.cb_grabar_lineas_pedidos
this.Control[iCurrent+49]=this.pb_actualizar_cabecera
this.Control[iCurrent+50]=this.st_descuento
this.Control[iCurrent+51]=this.st_seccion
this.Control[iCurrent+52]=this.uo_seccion
this.Control[iCurrent+53]=this.pb_seccion
this.Control[iCurrent+54]=this.st_cuenta
this.Control[iCurrent+55]=this.pb_cuenta
this.Control[iCurrent+56]=this.uo_cuenta
this.Control[iCurrent+57]=this.st_nom
this.Control[iCurrent+58]=this.dw_1
this.Control[iCurrent+59]=this.dw_lineas_pedidos
this.Control[iCurrent+60]=this.em_descuento
this.Control[iCurrent+61]=this.cb_2
this.Control[iCurrent+62]=this.dw_existencias
this.Control[iCurrent+63]=this.p_cursor
end on

on w_mant_comlinalb.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_grabar)
destroy(this.cb_borrar)
destroy(this.pb_salir)
destroy(this.st_mprima)
destroy(this.st_cantidad)
destroy(this.st_precio)
destroy(this.st_f_entrega)
destroy(this.uo_prima)
destroy(this.uo_medida)
destroy(this.em_precio)
destroy(this.em_fechaent)
destroy(this.em_imp)
destroy(this.st_importe)
destroy(this.pb_c)
destroy(this.cb_anyadir_desde_pedidos)
destroy(this.em_alb)
destroy(this.em_anyo2)
destroy(this.st_8)
destroy(this.cb_sal)
destroy(this.pb_imp)
destroy(this.dw_listado)
destroy(this.gb_7)
destroy(this.gb_5)
destroy(this.cb_insertar)
destroy(this.st_envase)
destroy(this.uo_envase)
destroy(this.st_descripcion)
destroy(this.em_descripcion)
destroy(this.cb_procesar)
destroy(this.texto_ayuda)
destroy(this.pb_1)
destroy(this.dw_2_aux)
destroy(this.dw_2)
destroy(this.gb_2)
destroy(this.cb_1)
destroy(this.em_cantidad)
destroy(this.gb_3)
destroy(this.gb_1)
destroy(this.st_nombre_moneda1)
destroy(this.st_nombre_moneda2)
destroy(this.pb_borraralb)
destroy(this.cb_borraralb)
destroy(this.gb_89)
destroy(this.cb_newalb)
destroy(this.pb_salir_lineas_pedidos)
destroy(this.cb_salir_lineas_pedidos)
destroy(this.pb_grabar_lineas_pedidos)
destroy(this.cb_grabar_lineas_pedidos)
destroy(this.pb_actualizar_cabecera)
destroy(this.st_descuento)
destroy(this.st_seccion)
destroy(this.uo_seccion)
destroy(this.pb_seccion)
destroy(this.st_cuenta)
destroy(this.pb_cuenta)
destroy(this.uo_cuenta)
destroy(this.st_nom)
destroy(this.dw_1)
destroy(this.dw_lineas_pedidos)
destroy(this.em_descuento)
destroy(this.cb_2)
destroy(this.dw_existencias)
destroy(this.p_cursor)
end on

event ue_recuperar;string moneda
int    decimales_precios

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(em_anyo2.text))
criterio[2]   =  trim(em_anyo2.text)+space(20-longitud)
longitud      =  len(trim(em_alb.text))
criterio[3]   =  trim(em_alb.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         = "comcabalb"

long cab,lini

lini = dw_1.Retrieve(codigo_empresa,em_anyo2.text,em_alb.Text)
cab  = dw_2.Retrieve(codigo_empresa,em_anyo2.text,em_alb.Text)

pb_actualizar_cabecera.enabled = false


if cab = 0 then
	dw_2.insertrow(1)
		
	dw_2.object.empresa[1]      = codigo_empresa 
	dw_2.object.anyo[1]         = string(dec(em_anyo2.text),"####")
	dw_2.object.albaran[1]      = string(dec(em_alb.text),"##########")
	dw_2.object.fecha_alb[1]    = datetime(today())
	dw_2.object.recibido_por[1] = nombre_usuario
	dw_2.setfocus()
	dw_2.setcolumn("fecha_alb")
	
	em_anyo2.enabled          = false
	em_alb.enabled            = false
	cb_borraralb.enabled      = false
	cb_newalb.enabled         = TRUE
	cb_anyadir_desde_pedidos.enabled = TRUE	
	cb_sal.enabled            = TRUE
	
	if lini > 0 then
		messagebox("Atención!!","Error lineas de albarán sin cabecera.")
	end if
	actualizar_cabecera = true
else
	cb_borraralb.enabled      = true
	cb_newalb.enabled         = false
	cb_anyadir_desde_pedidos.enabled = true
	cb_sal.enabled            = true
	
	if dw_2.rowcount() = 1 then
		moneda            = dw_2.object.moneda[1]
		decimales_precios = dw_2.object.decimales_precios[1]
		
		if isnull(moneda) then moneda = ""
		if isnull(decimales_precios) then decimales_precios = 0
		
		em_precio.setmask(decimalmask!,f_mascara_decimales(decimales_precios))
		em_imp.setmask(decimalmask!,f_mascara_moneda(moneda))
		st_nombre_moneda1.text = f_nombre_moneda_abr(moneda)
		st_nombre_moneda2.text = f_nombre_moneda_abr(moneda)	
		f_mascara_columna(dw_1,"precio",f_mascara_decimales(decimales_precios))
	end if
	
	actualizar_cabecera = false
end if
end event

event open;call super::open;Long hay

istr_parametros.s_titulo_ventana = "Mantenimiento de Albaranes de Compra"
istr_parametros.s_listado        = ""
 This.title = istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_2.SetTransObject(SQLCA)
dw_existencias.SetTransObject(SQLCA)
dw_lineas_pedidos.SetTransObject(SQLCA)

em_anyo2.text=string(year(Today()))

   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
		em_anyo2.text=istr_parametros.s_argumentos[3]
      em_alb.text=istr_parametros.s_argumentos[2]
		IF Trim(em_alb.text)<>"" and Not IsNull(em_alb.text) Then
       f_activar_campo(uo_prima.em_campo)
		 TriggerEvent("recuperar")
      END IF
		END IF

dw_1.Retrieve(codigo_empresa,em_anyo2.text,em_alb.Text)
hay = dw_2.Retrieve(codigo_empresa,em_anyo2.text,em_alb.Text)
IF hay > 0 THEN
	cb_newalb.enabled				= false
	cb_borraralb.enabled			= true
	cb_anyadir_desde_pedidos.enabled	= true
	em_anyo2.enabled				= true
	em_alb.enabled					= true
END IF
em_alb.SetFocus()
cb_grabar.enabled   = false
cb_borrar.enabled   = false
cb_sal.enabled      = false
cb_insertar.enabled = true


end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_cursor_abajo(dw_1)
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;f_cursor_arriba(dw_1)
end event

event close;call super::close;long anyo, v_albaran

v_albaran = long(em_anyo2.text)

connect using sqlca;
delete from comparamalb 
where usuario = :nombre_usuario;

if sqlca.sqlcode= 0 then 
	commit using SQLCA;
else
	rollback using SQLCA;
	messagebox("Error","Error borrando los numeros de albaran de la tabla comparamalb",StopSign!)
end if

end event

event activate;call super::activate;w_mant_comlinalb = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_mant_comlinalb
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_mant_comlinalb
integer taborder = 10
end type

event sle_opcion_orden::getfocus;call super::getfocus;em_alb.setfocus()
end event

type st_empresa from w_int_con_empresa`st_empresa within w_mant_comlinalb
integer x = 14
integer y = 16
integer width = 4850
integer height = 88
end type

type cb_grabar from commandbutton within w_mant_comlinalb
integer x = 2674
integer y = 2612
integer width = 329
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Grabar"
end type

event clicked;string   var_anyo,var_alb,var_linea,var_mprima,var_medida,var_descripcion,var_observaciones
string   var_seccion,var_subseccion,calm,var_cuentamp,situ,var_moneda,var_envase
decimal  var_cantidad,var_precio,var_importe,var_descuento
datetime var_entrega



var_anyo        = em_anyo2.text
var_alb         = em_alb.text
var_mprima      = uo_prima.em_codigo.text	

if isnull(uo_cuenta.text) then uo_cuenta.text = ""
if uo_cuenta.text = "" then
	var_cuentamp    = f_cuenta_mprima(codigo_empresa,var_mprima)
else
	var_cuentamp    = uo_cuenta.text
end if
var_cantidad    = dec(em_cantidad.text)
var_descripcion = em_descripcion.text
var_precio      = dec(em_precio.text)
var_descuento   = dec(em_descuento.text)

if dw_2.rowcount() = 1 then
	var_moneda = dw_2.object.moneda[1]
else
	return
end if

var_importe    = dec(string(var_precio * var_cantidad,f_mascara_moneda(var_moneda)))

If var_descuento > 0 then
	var_importe = var_importe - ((var_importe / 100) * var_descuento)
	var_importe = dec(string(var_importe,f_mascara_moneda(var_moneda)))
end if

IF Trim(em_fechaent.text) = "" THEN
	em_fechaent.SetFocus()
	return
END IF
var_entrega    = datetime(date(em_fechaent.text))
var_medida     = uo_medida.em_codigo.text
var_envase     = uo_envase.em_codigo.text  
var_seccion    = uo_seccion.em_codigo.text
setnull(var_subseccion)

if var_mprima="" Then
	messagebox("Campo obligatorio","Materia Prima")
	uo_prima.em_campo.SetFocus()
	return
end if
//if var_envase="" Then
//	messagebox("Campo obligatorio","Envase")	
//	uo_envase.em_campo.SetFocus()
//	return
//end if

/* Comentado por David el 09-07-02
if var_seccion = "" Then
	messagebox("Campo obligatorio","Sección")
	uo_seccion.em_campo.SetFocus()
	return
end if
*/

//if var_subseccion="" Then
//	uo_subseccion.em_campo.SetFocus()
//	return
//end if

if em_cantidad.text="" Then 
	messagebox("Campo obligatorio","Cantidad")	
	em_cantidad.SetFocus()
	return
end if

if var_medida="" or isnull(var_medida) Then 
	messagebox("Campo obligatorio","Medida")	
	uo_medida.em_campo.SetFocus()
	return
end if

if em_precio.text="" Then
	messagebox("Campo obligatorio","Precio")	
	em_precio.SetFocus()
	return
end if
	
IF cb_borrar.enabled=TRUE THEN
	IF dec(dw_1.getitemnumber(numrow,"cantidad")) > dec(em_cantidad.text) then
		integer opc
		opc=messagebox("Cantidad modificada","Desea restituir el resto en el pedido",question!,yesno!)
		IF opc=1 THEN f_restituir(numrow,dec(em_cantidad.text))
	ELSE
		IF dec(dw_1.getitemnumber(numrow,"cantidad")) < dec(em_cantidad.text) then
			long existe_linped
				SELECT count(*) INTO :existe_linped FROM comlinpedpro  
				WHERE ( comlinpedpro.empresa = :codigo_empresa ) AND  
						( comlinpedpro.mprima = :var_mprima )   ;
			if sqlca.sqlcode<>0 then existe_linped=0
			IF existe_linped<>0 THEN
				long op
				op=messagebox("Existen "+string(existe_linped)+" lineas de pedido pendientes con ese artículo","Desea seleccionar una de ellas",question!,yesnocancel!)
				choose case op
					case 1 
						cb_anyadir_desde_pedidos.triggerevent(clicked!)
						return
					case 2
					case 3
						em_cantidad.text=string(dw_1.getitemnumber(numrow,"cantidad"))
						em_cantidad.setfocus()
						return
				end choose
			END IF
		END IF
	END IF
	var_linea = numlinea
	UPDATE comlinalb  SET empresa 		= :codigo_empresa,
								anyo 				= :var_anyo,  
								albaran 			= :var_alb,   
								linea 			= :var_linea,   
								mprima 			= :var_mprima,
								cantidad 		= :var_cantidad, 
								precio 			= :var_precio,
								descuento      = :var_descuento,
								importe        = :var_importe,
								fecha_entrega 	= :var_entrega,  
								unidad_medida 	= :var_medida,
								descripcion 	= :var_descripcion,
								envase		  	= :var_envase,
								seccion			= :var_seccion,
								subseccion		= :var_subseccion,
								cuenta         = :var_cuentamp
	Where empresa = :codigo_empresa
	and   anyo    = :var_anyo
	and   albaran = :var_alb
	and   linea   = :var_linea;
	
	IF sqlca.sqlcode <> 0 THEN 
		messagebox("Error al modificar la linea",sqlca.sqlerrtext)
		ROLLBACK;
	ELSE
		commit;
		if actualizar_cabecera then
			if dw_2.update() = -1 then
				messagebox("Error!!","Se ha producido un error al actualizar la cabecera.~n"+sqlca.sqlerrtext)
				rollback;
			else
				actualizar_cabecera = false
				COMMIT;
			end if			
		end if			
	END IF
ELSE

	situ = "N"
	var_linea = f_ultima_linea()
	INSERT INTO comlinalb  
		(empresa,						anyo,						albaran,
		 linea,							mprima,					cantidad,
		 precio,							fecha_entrega,			unidad_medida,
		 pedido,							linea_pedido,			situacion,
		 observaciones,				libre,					anyo_pedido,
		 fecha_control,				envase,					descripcion,
		 seccion,						subseccion,				ubicado,
		 cuenta,							importe,             descuento)  
	VALUES 
		(:codigo_empresa,				:var_anyo,				:var_alb,
		:var_linea,						:var_mprima,			:var_cantidad,
		:var_precio,					:var_entrega,			:var_medida,
		null,								null,						:situ,
		:var_observaciones,			"N",						null,
		null,								:var_envase,			:var_descripcion,
		:var_seccion,					:var_subseccion,		"N",
		:var_cuentamp,					:var_importe,			:var_descuento);
		
	IF sqlca.sqlcode <> 0 THEN 
		messagebox("Error al insertar linea",sqlca.sqlerrtext)
		ROLLBACK;
	ELSE
		COMMIT;
		if actualizar_cabecera then
			if dw_2.update() = -1 then
				messagebox("Error!!","Se ha producido un error al actualizar la cabecera.~n"+sqlca.sqlerrtext)
				rollback;
			else
				actualizar_cabecera = false
				COMMIT;
			end if			
		end if			
	END IF
END IF

dw_1.Retrieve(codigo_empresa,em_anyo2.text,em_alb.Text)

// Control de si es un nuevo albaran sin pedidos y no han pulsado
// el boton aceptar de la cabecera
IF Not f_existe_albaran() THEN
	dw_2.TriggerEvent(Clicked!)
END IF

em_cantidad.text          = "0"
em_precio.text            = "0"
em_descuento.text         = "0"
em_imp.text               = "0"
em_descripcion.text       = ""
em_fechaent.text          = ""
uo_prima.em_codigo.text   = ""
uo_prima.em_campo.text    = ""
uo_medida.em_codigo.text  = ""
uo_medida.em_campo.text   = ""
uo_envase.em_codigo.text  = ""
uo_envase.em_campo.text   = ""
uo_seccion.em_codigo.text = ""
uo_seccion.em_campo.text  = ""
uo_cuenta.text = ""
st_nom.text = ""

cb_borrar.enabled			= false
cb_grabar.enabled			= false
cb_sal.enabled 			= false
cb_insertar.enabled		= TRUE
uo_prima.enabled 			= false
uo_medida.enabled 		= false
uo_envase.enabled 		= false
em_cantidad.enabled 		= false
em_fechaent.enabled 		= false
em_precio.enabled 		= false
em_descuento.enabled 	= false
em_descripcion.enabled	= false

cb_newalb.enabled				      = false
cb_borraralb.enabled			      = true
cb_anyadir_desde_pedidos.enabled	= true
em_anyo2.enabled				      = true
em_alb.enabled					      = true

dw_1.selectrow(0,false)
em_alb.setfocus()

end event

type cb_borrar from commandbutton within w_mant_comlinalb
integer x = 2674
integer y = 2688
integer width = 329
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Borrar"
end type

event clicked;string     var_anyo,var_alb,var_linea,anyo_ped,ped,linped,var_mprima,var_calidad
decimal{2} var_cantidad
dec        var_precio
String     alm_entra,var_ubicado,var_envase
long       decision

	if dw_1.getrow() <> 0 then
		var_anyo        = em_anyo2.text
		var_alb         = em_alb.text
		var_linea       = dw_1.getitemstring(dw_1.getrow(),"linea")
		var_mprima      = dw_1.getitemstring(dw_1.getrow(),"mprima")
		var_cantidad    = dw_1.getitemnumber(dw_1.getrow(),"cantidad")
		var_calidad     = "1"
		var_precio      = dw_1.getitemnumber(dw_1.getrow(),"precio")
		var_envase      = dw_1.getitemstring(dw_1.getrow(),"envase")
		var_ubicado     = dw_1.getitemstring(dw_1.getrow(),"ubicado")
		var_precio      = dw_1.getitemnumber(dw_1.getrow(),"precio")
		// Miro si la línea viene de un pedido
		anyo_ped        = dw_1.getitemstring(dw_1.getrow(),"anyo_pedido")
		ped             = dw_1.getitemstring(dw_1.getrow(),"pedido")
		linped          = dw_1.getitemstring(dw_1.getrow(),"linea_pedido")
		
		IF Not f_bloquear_almacen_compras(w_mant_comlinalb.title) Then
			
			IF Trim(anyo_ped) <> "" AND Trim(ped) <> "" AND Trim(linped) <> "" THEN
				decision = messagebox("Borrar linea de albarán","Desea restituir la linea en el pedido",Question!,Yesno!)
				IF decision = 1 THEN
					f_restituir(dw_1.getrow(),0)
				END IF
			END IF
			
			Delete From comlinalb
			Where empresa = :codigo_empresa
			and   anyo    = :var_anyo
			and   albaran = :var_alb
			and   linea   = :var_linea;
			
			if sqlca.sqlcode <> 0 then 
				messagebox("Error al borrar la linea",sqlca.sqlerrtext)
				rollback;
			else
				if var_ubicado = "S" and f_control_almacen(codigo_empresa,var_mprima) = "S" then
					if dw_existencias.visible then
						if f_salida_almacen(var_mprima,var_calidad,var_cantidad,var_envase,var_precio) then
							commit USING SQLCA;
						else
	  						rollback USING SQLCA;
							messagebox("Error en la salida de almacén",sqlca.sqlerrtext)
						end if
					else
						rollback USING SQLCA;
						MessageBox("No ha seleccionado una ubicación","Pulse y botón Ubicaciones y selecciona una.")
					end if
		else
					commit USING SQLCA;
				end if
			end if		
			f_desbloquear_almacen_compras(w_mant_comlinalb.title)
		END IF
	end if
	
	dw_1.Retrieve(codigo_empresa,em_anyo2.text,em_alb.Text)
	uo_prima.em_codigo.text  = ""
	uo_prima.em_campo.text   = ""
	em_cantidad.text         = ""
	em_precio.text           = ""
	em_imp.text              = ""
	em_fechaent.text         = ""
	uo_medida.em_codigo.text = ""
	uo_medida.em_campo.text  = ""
	uo_envase.em_codigo.text = ""
	uo_envase.em_campo.text  = ""
	uo_cuenta.text = ""
	st_nom.text = ""
	
	cb_grabar.enabled         = false
	cb_borrar.enabled         = false
	cb_sal.enabled            = false
	uo_prima.enabled          = false
	uo_medida.enabled         = false
	uo_envase.enabled         = false
	em_cantidad.enabled       = false
	em_fechaent.enabled       = false
	em_precio.enabled         = false
	cb_newalb.enabled         = false
	cb_borraralb.enabled      = true
	cb_anyadir_desde_pedidos.enabled = true
	em_anyo2.enabled          = true
	em_alb.enabled            = true
	
	dw_1.selectrow(0,false)
	em_alb.setfocus()

dw_existencias.visible = false
end event

type pb_salir from upb_salir within w_mant_comlinalb
integer x = 4878
integer y = 12
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

event clicked;call super::clicked;//IF pb_actualizar_cabecera.enabled=TRUE THEN
//	integer anyo,cuantos=0
//	dec albaran,par_albaran
//	anyo=integer(em_anyo2.text)
//	albaran=dec(em_alb.text)
//	
//	select count(*)
//	into :cuantos
//	from venalb
//	where empresa=:codigo_empresa and
//			anyo=:anyo and
//			albaran=:albaran;
//			
//	if cuantos=0 then 
//		select albaran
//		into :par_albaran
//		from comparamalb
//		where empresa=:codigo_empresa and
//				anyo=:anyo;
//				
//		if par_albaran=albaran then
//			update comparamalb
//			set albaran=albaran - 1
//			where empresa=:codigo_empresa and
//					anyo=:anyo;
//					
//			if sqlca.sqlcode<>0 then
//				f_mensaje("Atención","Error al modificar venparamalb")
//				rollback;
//			else
//				commit;
//			end if
//		end if
//	end if
//end if
//
//call super::clicked
end event

type st_mprima from statictext within w_mant_comlinalb
integer x = 5
integer y = 2436
integer width = 1600
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12639424
boolean enabled = false
string text = "ARTÍCULO"
boolean border = true
boolean focusrectangle = false
end type

type st_cantidad from statictext within w_mant_comlinalb
integer x = 1701
integer y = 2436
integer width = 613
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12639424
boolean enabled = false
string text = "Cantidad"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_precio from statictext within w_mant_comlinalb
integer x = 2665
integer y = 2436
integer width = 448
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12639424
boolean enabled = false
string text = "Precio"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_f_entrega from statictext within w_mant_comlinalb
integer x = 3355
integer y = 2436
integer width = 251
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12639424
boolean enabled = false
string text = "F.Ent."
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type uo_prima from u_em_campo_2 within w_mant_comlinalb
integer x = 5
integer y = 2512
integer width = 1687
integer taborder = 170
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;dec    precio,cambio_moneda_albaran,cambio_moneda_proveedor
int    decimales_precios
string proveedor,moneda_albaran,moneda_proveedor

uo_prima.em_campo.text=f_nombre_mprima(codigo_empresa,uo_prima.em_codigo.text)
IF Trim(uo_prima.em_campo.text)="" THEN
	If Trim(uo_prima.em_codigo.text)<>"" THEN uo_prima.em_campo.SetFocus()
	uo_prima.em_campo.text=""
	uo_prima.em_codigo.text=""
END IF

proveedor        = dw_2.object.proveedor[1]
moneda_albaran   = dw_2.object.moneda[1]
moneda_proveedor = f_moneda_genter(codigo_empresa,"P",proveedor)
precio           = f_precio_mprima(codigo_empresa,proveedor,uo_prima.em_codigo.text)

if moneda_proveedor <> moneda_albaran then
	cambio_moneda_proveedor = f_cambio_moneda(moneda_proveedor)
	cambio_moneda_albaran   = dw_2.object.cambio[1]
	
	decimales_precios       = dw_2.object.decimales_precios[1]
	
	if cambio_moneda_proveedor <> 0 then
		precio = (precio / cambio_moneda_proveedor) * cambio_moneda_albaran
		precio = round(precio,decimales_precios)
	end if
end if

em_precio.SetMask(Decimalmask!, f_mascara_decimales(dw_2.object.decimales_precios[1]))
em_precio.text              = string(precio)



uo_medida.em_codigo.text    = f_unimedida_mprima(codigo_empresa,uo_prima.em_codigo.text)
uo_medida.em_campo.text     = f_nombre_unimedida(uo_medida.em_codigo.text)
uo_envase.em_codigo.text    = f_envase_mprima(codigo_empresa,uo_prima.em_codigo.text)
uo_envase.em_campo.text     = f_nombre_envase(uo_envase.em_codigo.text)
uo_seccion.em_codigo.text   = f_seccion_mprima(codigo_empresa,uo_prima.em_codigo.text)
uo_seccion.em_campo.text    = f_nombre_contaseccion(codigo_empresa,uo_seccion.em_codigo.text)

em_cantidad.SetMask(Decimalmask!, f_mascara_unidad_com(uo_medida.em_codigo.text))


uo_envase.ue_valor_anterior  = uo_envase.em_campo.text  
uo_medida.ue_valor_anterior  = uo_medida.em_campo.text  
uo_seccion.ue_valor_anterior = uo_seccion.em_codigo.text

em_descripcion.text         = f_nombre_mprima(codigo_empresa,uo_prima.em_codigo.text)

string ref_proveedor

select ref_proveedor
into :ref_proveedor
from comartpro
where empresa = :codigo_empresa
and mprima = :uo_prima.em_codigo.text
and proveedor = :proveedor;
st_mprima.text = "ARTÍCULO:    "+ref_proveedor


//if cb_insertar.enabled=false then
//	em_fechaent.text=string(date(f_fentrega_cabped(codigo_empresa,em_anyo2.text,em_pedido.text)))
//end if
end event

event getfocus;call super::getfocus;String	prove
prove = Trim(dw_2.GetItemString(1,"proveedor"))

ue_datawindow =  "dw_ayuda_venmprima_compras"
ue_titulo     =  "AYUDA SELECCION DE MATERIAS"
ue_filtro     =  "proveedor='" + prove + "' or proveedor = '' OR IsNull(proveedor)"
valor_empresa = TRUE
end event

on uo_prima.destroy
call u_em_campo_2::destroy
end on

type uo_medida from u_em_campo_2 within w_mant_comlinalb
integer x = 2208
integer y = 2512
integer width = 101
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_medida.em_campo.text=f_nombre_unimedida(uo_medida.em_codigo.text)
If Trim(uo_medida.em_campo.text)="" Then
	If Trim(uo_medida.em_codigo.text)<>"" then uo_medida.em_campo.SetFocus()
	uo_medida.em_campo.text=""
	uo_medida.em_codigo.text=""
end if

if f_unimedida_mprima(codigo_empresa,uo_prima.em_codigo.text)<>uo_medida.em_codigo.text then
	integer op
	op=messagebox("Unidad de medida modificada","Desea modificar la unidad en la ficha del articulo",question!,yesno!)
	if op=1 then
		f_act_unimedida(uo_prima.em_codigo.text,uo_medida.em_codigo.text)
	end if
end if

end event

event getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_comunimedida"
ue_titulo     =  "AYUDA SELECCION DE UNIDADES DE MEDIDA"
ue_filtro     =  ""
valor_empresa = false
end event

on uo_medida.destroy
call u_em_campo_2::destroy
end on

type em_precio from u_em_campo within w_mant_comlinalb
integer x = 2665
integer y = 2512
integer width = 398
integer taborder = 210
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = ""
end type

event modified;dec    precio,importe,descuento,cantidad
String proveedor,moneda_albaran,moneda_proveedor,mascara_moneda,mprima, tipo_materia

proveedor        = Trim(dw_2.GetItemString(1,"proveedor"))
moneda_albaran   = Trim(dw_2.GetItemString(1,"moneda"))
moneda_proveedor = f_moneda_genter(codigo_empresa,"P",proveedor)
mascara_moneda   = f_mascara_moneda(moneda_albaran)
mprima           = uo_prima.em_codigo.text
precio           = dec(this.text)
descuento        = dec(em_descuento.text)
cantidad         = dec(em_cantidad.text)

if precio <> 0 and moneda_albaran = moneda_proveedor then
	if f_precio_mprima(codigo_empresa,proveedor,mprima) <> precio then
		if messagebox("Precio modificado","Desea modificar el precio en la ficha del articulo",question!,yesno!) = 1 then
			f_act_precio_mprima(proveedor,mprima,precio)
			tipo_materia = ""
			SELECT tipo_materia INTO :tipo_materia FROM venmprima WHERE empresa = :codigo_empresa AND codigo = :mprima;
			if ( tipo_materia = '16' or tipo_materia = '17' ) then
				if  MessageBox("Atención", "Desea recalcular costes para el proveedor",  Question!, YesNO!, 2) = 1 then
					f_recalculo_costes_formulas (codigo_empresa, mprima)
				end if		
			end if
		end if
	end if
end if

importe = dec(string(cantidad * precio,mascara_moneda))

if descuento <> 0 then
	importe = importe - ((importe / 100) * descuento)
	importe = dec(string(importe,mascara_moneda))
end if

em_imp.text = string(importe)
end event

type em_fechaent from u_em_campo within w_mant_comlinalb
integer x = 3355
integer y = 2512
integer taborder = 0
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "Ä"
end type

type em_imp from editmask within w_mant_comlinalb
integer x = 3611
integer y = 2512
integer width = 485
integer height = 84
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,###,##0.00"
end type

type st_importe from statictext within w_mant_comlinalb
integer x = 3611
integer y = 2436
integer width = 571
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12639424
boolean enabled = false
string text = "Importe"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type pb_c from picturebutton within w_mant_comlinalb
integer x = 654
integer y = 192
integer width = 119
integer height = 104
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
boolean originalsize = true
string picturename = "c:\bmp\calcula.bmp"
alignment htextalign = left!
end type

event clicked;dec n_alb, n_alblinfac, n_cabalb 
long d_anyo, TIEMPO_ESPERA
d_anyo = dec(em_anyo2.text)
boolean exito

if isnull(em_anyo2.text) or em_anyo2.text="" then
	em_anyo2.setfocus()
	return
end if
 

tiempo_espera = 0
exito = false
n_alb = 0

// Borrar los bloqueos del usuario actual (En el close de la ventana tambien borraremos los bloqueos del usuario)
long anyo, v_albaran

v_albaran = long(em_anyo2.text)

connect using sqlca;
delete from comparamalb 
where usuario = :nombre_usuario;

if sqlca.sqlcode= 0 then 
	commit using SQLCA;
else
	rollback using SQLCA;
	messagebox("Error","Error borrando los numeros de albaran de la tabla comparamalb",StopSign!)
end if
// Fin de borrar bloqueos del usuario actual

DO WHILE tiempo_Espera < 10 and not exito
	SELECT max(convert(integer,comlinfac.albaran)) INTO :n_alblinfac FROM comlinfac  
	WHERE comlinfac.empresa = :codigo_empresa
	AND   comlinfac.anyo_albaran 	  = :d_anyo USING SQLCA;

	SELECT max(convert(integer,comcabalb.albaran)) INTO :n_cabalb FROM comcabalb  
	WHERE comcabalb.empresa = :codigo_empresa
	AND   comcabalb.anyo 	  = :d_anyo USING SQLCA;
	
	if n_alb > n_alblinfac and n_alb > n_cabalb then
		n_alb = n_alb + 1
	else
		if n_alblinfac > n_cabalb then
			n_alb = n_alblinfac + 1
		else
			n_alb = n_cabalb +1
		end if
	end if
	if n_alb = 0 or isnull(n_alb) then
		n_alb = 1
	end if

	INSERT INTO comparamalb (empresa,anyo,albaran, usuario)
					VALUES (:codigo_empresa,:d_anyo,:n_alb, :nombre_usuario);
	if sqlca.sqlcode= 0 then 
		commit;
		exito = true
	else
		rollback;
		tiempo_Espera ++
	end if
LOOP


em_alb.text = string(n_alb)
em_alb.triggerevent("modificado")
em_alb.setfocus()
	

end event

type cb_anyadir_desde_pedidos from commandbutton within w_mant_comlinalb
event clicked pbm_bnclicked
integer x = 3351
integer y = 2688
integer width = 745
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Añadir lineas desde Pedidos"
end type

event clicked;//if em_anyo2.text="" then
//	em_anyo2.setfocus()
//	return
//end if
//if em_alb.text="" then
//	em_alb.setfocus()
//	return
//end if
//
//str_parametros lstr_param
//lstr_param.i_nargumentos=4
//lstr_param.s_argumentos[2]=em_anyo2.text
//lstr_param.s_argumentos[3]=em_alb.text
//IF f_existe_albaran() THEN
//	lstr_param.s_argumentos[4]="Añadir"
//ELSE
//	lstr_param.s_argumentos[4]="Nuevo"
//END IF
//
//OpenWithParm(w_con_pedidos_alb, lstr_param)
//em_alb.setfocus()
//cb_insertar.enabled = TRUE
string proveedor

if dw_2.rowcount() = 1 then
	proveedor = dw_2.object.proveedor[1]
	
	if isnull(proveedor) then proveedor = ""
	if trim(proveedor) <> "" then
		if dw_lineas_pedidos.retrieve(codigo_empresa,proveedor) > 0 then				
			dw_lineas_pedidos.visible        = true
			cb_grabar_lineas_pedidos.visible = true
			cb_salir_lineas_pedidos.visible  = true
			pb_grabar_lineas_pedidos.visible = true
			pb_salir_lineas_pedidos.visible  = true			
		else
			messagebox("Atención!!","No hay pedidos pendientes.")
			dw_lineas_pedidos.visible        = false
			cb_grabar_lineas_pedidos.visible = false
			cb_salir_lineas_pedidos.visible  = false		
			pb_grabar_lineas_pedidos.visible = false
			pb_salir_lineas_pedidos.visible  = false					
		end if
	end if
end if


end event

type em_alb from u_em_campo within w_mant_comlinalb
integer x = 389
integer y = 200
integer width = 238
integer taborder = 0
fontcharset fontcharset = ansi!
string facename = "Arial"
maskdatatype maskdatatype = numericmask!
string mask = "######"
string displaydata = ""
end type

event modificado;call super::modificado;parent.triggerevent("ue_recuperar")

end event

event getfocus;call super::getfocus;pb_c.visible=true
pb_c.enabled=true
cb_newalb.enabled=true
ue_datawindow =  "dw_ayuda_comcabalb"
ue_titulo     =  "AYUDA SELECCION DE ALBARANES COMPRAS"
ue_filtro     =  "anyo = '"+em_anyo2.text+"'"
valor_empresa = TRUE
end event

event losefocus;call super::losefocus;GraphicObject h_control

h_control = GetFocus()
if isnull(h_control) then
	pb_c.visible=false
	return
end if

CHOOSE CASE TypeOf(h_control)

CASE PictureButton!
	//
case else
	pb_c.visible=false
end choose


end event

event tecla_tabulador;call super::tecla_tabulador;//dw_2.Retrieve(codigo_empresa,em_anyo2.text,em_alb.text)
end event

type em_anyo2 from u_em_campo within w_mant_comlinalb
integer x = 82
integer y = 200
integer width = 219
integer taborder = 0
fontcharset fontcharset = ansi!
string facename = "Arial"
maskdatatype maskdatatype = numericmask!
string mask = "######"
string displaydata = ""
end type

type st_8 from statictext within w_mant_comlinalb
integer x = 311
integer y = 208
integer width = 69
integer height = 76
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "/"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_sal from commandbutton within w_mant_comlinalb
integer x = 3003
integer y = 2688
integer width = 329
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

event clicked; 
dw_1.Retrieve(codigo_empresa,em_anyo2.text,em_alb.Text)
uo_prima.em_codigo.text  = ""
uo_prima.em_campo.text   = ""
em_cantidad.text         = ""
em_precio.text           = ""
em_imp.text              = ""
em_fechaent.text         = ""
uo_medida.em_codigo.text = ""
uo_medida.em_campo.text  = ""
uo_envase.em_codigo.text = ""
uo_envase.em_campo.text  = ""
uo_cuenta.text = ''
st_nom.text = ''
em_descripcion.text         = ""

cb_grabar.enabled 			      = false
cb_borrar.enabled 			      = false
cb_sal.enabled 				      = false
uo_prima.enabled 				      = false
uo_medida.enabled 			      = false
uo_envase.enabled 			      = false
em_cantidad.enabled 			      = false
em_fechaent.enabled 			      = false
em_precio.enabled 			      = false
cb_newalb.enabled				      = false
cb_insertar.enabled 			      = TRUE
cb_borraralb.enabled			      = true
cb_anyadir_desde_pedidos.enabled = true
em_anyo2.enabled				      = true
em_alb.enabled					      = true

dw_1.selectrow(0,false)
em_alb.setfocus()
end event

type pb_imp from upb_imprimir within w_mant_comlinalb
integer x = 814
integer y = 168
integer width = 183
integer height = 160
integer taborder = 0
string picturename = "c:\bmp\imp32.bmp"
end type

event clicked;call super::clicked;if isnull(em_alb.text) or em_alb.text="" then
	messagebox("No hay albarán seleccionado","Introduzca el nº de Albarán")
	em_alb.setfocus()
	return
end if
dw_listado.settransobject(SQLCA)
dw_listado.Retrieve(codigo_empresa,em_anyo2.text,em_alb.text)
//dw_listado.Print(TRUE) 
f_imprimir_datawindow(dw_listado)

end event

type dw_listado from datawindow within w_mant_comlinalb
boolean visible = false
integer x = 2400
integer width = 155
integer height = 88
boolean bringtotop = true
string dataobject = "report_comalbaranes"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type gb_7 from groupbox within w_mant_comlinalb
integer x = 805
integer y = 132
integer width = 192
integer height = 196
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_5 from groupbox within w_mant_comlinalb
integer x = 9
integer y = 132
integer width = 786
integer height = 196
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Anyo             Albarán"
borderstyle borderstyle = styleraised!
end type

type cb_insertar from commandbutton within w_mant_comlinalb
event clicked pbm_bnclicked
integer x = 3003
integer y = 2612
integer width = 329
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Insertar"
end type

event clicked;cb_grabar.enabled 		= TRUE
cb_borrar.enabled 		= FALSE
cb_insertar.enabled 		= FALSE
cb_sal.enabled 			= TRUE
uo_prima.enabled 			= TRUE
uo_medida.enabled 		= TRUE
uo_envase.enabled 		= TRUE
em_cantidad.enabled 		= TRUE
em_fechaent.enabled 		= TRUE
em_precio.enabled 		= TRUE
em_descuento.enabled 	= TRUE
em_descripcion.enabled 	= TRUE

em_fechaent.text = String(date(dw_2.getitemdatetime(1,"fecha_alb")))

em_cantidad.text					= "0"
em_precio.text						= "0"
em_descuento.text					= "0"
em_imp.text							= "0"
em_descripcion.text				= ""

uo_prima.em_codigo.text			= ""
uo_prima.em_campo.text			= ""
uo_medida.em_codigo.text		= ""
uo_medida.em_campo.text			= ""
uo_envase.em_codigo.text		= ""
uo_envase.em_campo.text			= ""
uo_seccion.em_codigo.text		= ""
uo_seccion.em_campo.text		= ""

uo_prima.em_campo.SetFocus()

cb_newalb.enabled				      = false
cb_borraralb.enabled			      = false
cb_anyadir_desde_pedidos.enabled	= false
em_anyo2.enabled				      = false
em_alb.enabled					      = false

end event

type st_envase from statictext within w_mant_comlinalb
integer x = 2313
integer y = 2436
integer width = 343
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12639424
boolean enabled = false
string text = "Envase"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type uo_envase from u_em_campo_2 within w_mant_comlinalb
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 2313
integer y = 2512
integer width = 343
integer taborder = 200
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_envase.em_campo.text=f_nombre_envase_abr(uo_envase.em_codigo.text)
If Trim(uo_envase.em_campo.text)="" Then
	If Trim(uo_envase.em_codigo.text)<>"" then uo_envase.em_campo.SetFocus()
	uo_envase.em_campo.text=""
	uo_envase.em_codigo.text=""
end if

//if f_unienvase_mprima(codigo_empresa,uo_prima.em_codigo.text)<>uo_envase.em_codigo.text then
//	integer op
//	op=messagebox("Unidad de envase modificada","Desea modificar la unidad en la ficha del articulo",question!,yesno!)
//	if op=1 then
//		f_act_unienvase(uo_prima.em_codigo.text,uo_envase.em_codigo.text)
//	end if
//end if

end event

event getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_venenvases"
ue_titulo     =  "AYUDA SELECCION DE ENVASES"
ue_filtro     =  ""
valor_empresa = TRUE
end event

on uo_envase.destroy
call u_em_campo_2::destroy
end on

type st_descripcion from statictext within w_mant_comlinalb
integer x = 5
integer y = 2604
integer width = 1861
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12639424
boolean enabled = false
string text = "Descripción"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type em_descripcion from u_em_campo within w_mant_comlinalb
event modified pbm_enmodified
integer x = 5
integer y = 2688
integer width = 1861
integer taborder = 240
fontcharset fontcharset = ansi!
string facename = "Arial"
string mask = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
end type

type cb_procesar from commandbutton within w_mant_comlinalb
string tag = "Procesa las entradas de almacen"
integer x = 3351
integer y = 2604
integer width = 745
integer height = 76
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Confirmar / Ubicar Todo"
end type

event clicked;Long total_lineas,i
String anyo_st, albaran, linea_alb
datetime fech_control

//IF MESSAGEBOX("Proceso de ubicación","Este proceso ubica las lineas de albaran marcadas como aceptadas~n¿Desea continuar?",Question!,YesNo!,1) = 1 then
IF MESSAGEBOX("Proceso de Confirmación / Ubicación","Va a aceptar y ubicar todas las lineas de albaran.~n¿Desea continuar?",Question!,YesNo!,1) = 1 then
	
	//NUEVO (Para evitar confirmar -> Todo bueno -> confirmar

	dw_1.AcceptText()
	total_lineas=dw_1.rowcount()
	
	/**********************************************************************/
	/*						PROCESO POR CADA LÍNEA DE DW_1                      */
	/**********************************************************************/
	
	FOR i=1 TO total_lineas
				
		anyo_st   = dw_1.GetItemString(i,"anyo")
		albaran   = dw_1.GetItemString(i,"albaran")
		linea_alb = dw_1.GetItemString(i,"linea")
			
			
		// linea OK
		
		fech_control=datetime(today(),now())
		UPDATE comlinalb  
			SET situacion    = 'C',
			 fecha_control=:fech_control,
			 libre        = 'B'
		WHERE ( comlinalb.empresa =:codigo_empresa  ) AND  
				( comlinalb.anyo    =:anyo_st ) AND  
				( comlinalb.albaran =:albaran  ) AND  
				( comlinalb.linea   =:linea_alb  )   ;
				
		commit;			
	NEXT
	dw_1.Retrieve(codigo_empresa,em_anyo2.text,em_alb.Text)
	//FIN código nuevo
	
	f_procesar_entrada()
	dw_2.Retrieve(codigo_empresa,em_anyo2.text,em_alb.text)
	parent.triggerevent("ue_recuperar")
end if


end event

type texto_ayuda from statictext within w_mant_comlinalb
boolean visible = false
integer x = 1989
integer y = 960
integer width = 384
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean enabled = false
string text = "MMMMMMMMMM"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type pb_1 from picturebutton within w_mant_comlinalb
integer x = 1605
integer y = 2436
integer width = 87
integer height = 76
integer taborder = 160
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "c:\bmp\carpeta.bmp"
alignment htextalign = left!
end type

event clicked;str_parametros lstr_param

lstr_param.i_nargumentos    = 1
lstr_param.s_argumentos[1]  = "w_mant_comlinalb"

OpenWithParm(w_mant_venmprima2,lstr_param)  

end event

type dw_2_aux from datawindow within w_mant_comlinalb
boolean visible = false
integer x = 690
integer y = 620
integer width = 55
integer height = 60
boolean bringtotop = true
string dataobject = "dw_comcabalb"
boolean border = false
boolean livescroll = true
end type

event itemchanged;IF isnull(dwo) THEN return

IF dwo.Name = "proveedor" THEN
	string mone,for_pag 
	Dec	dtopp,dto1
	IF Not f_existe_albaran() THEN
		SELECT comproveedores.moneda,comproveedores.forma_pago,
				 comproveedores.dtopp, comproveedores.dto1
		INTO :mone,:for_pag,:dtopp,:dto1  FROM comproveedores  
		WHERE comproveedores.empresa = :codigo_empresa
		AND   comproveedores.codigo  = :data USING SQLCA;
		IF sqlca.sqlcode=0 THEN
			this.setitem(row,"moneda",mone)
			this.setitem(row,"forma_pago",for_pag)
			This.SetItem(row,"dtopp",dtopp)
			This.SetItem(row,"dto1",dto1)
		ELSE
			this.setitem(row,"moneda","")
			this.setitem(row,"forma_pago","")
			This.SetItem(row,"dtopp","")
			This.SetItem(row,"dto1","")
		END IF
	END IF
END IF
end event

type dw_2 from u_datawindow within w_mant_comlinalb
integer x = 1385
integer y = 172
integer width = 3145
integer height = 328
integer taborder = 80
string dataobject = "dw_comcabalb"
boolean border = false
end type

event rbuttondown;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "proveedor"
		bus_filtro =""
		bus_datawindow = "dw_ayuda_proveedores"
		bus_titulo = "AYUDA SELECCION DE PROVEEDORES"
	CASE "forma_pago"
	CASE "moneda"
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

event key;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "proveedor"
		bus_filtro =""
		bus_datawindow = "dw_ayuda_proveedores"
		bus_titulo = "AYUDA SELECCION DE PROVEEDORES"
	CASE "forma_pago"
	CASE "moneda"
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key
end event

event itemchanged;string   proveedor,moneda,forma_pago,albaran_proveedor,anyo,albaran,sel,mensaje
Dec	   dtopp,dto1,cambio
int      decimales_precios,existe_albaran,indice,total
datetime fecha_alb
long     lineas_albaran
datastore albaranes

actualizar_cabecera = true

choose case dwo.Name
	case "decimales_precios"
		decimales_precios = dec(data)
		
		em_precio.setmask(decimalmask!,f_mascara_decimales(decimales_precios))
		f_mascara_columna(dw_1,"precio",f_mascara_decimales(decimales_precios))		
	case "proveedor"
		proveedor = data
			
		SELECT moneda,				forma_pago,				dtopp,
				 dto1,				decimales_precios
		INTO   :moneda,			:forma_pago,			:dtopp,
				 :dto1,				:decimales_precios
		FROM   comproveedores  
		WHERE  comproveedores.empresa = :codigo_empresa
		AND    comproveedores.codigo  = :proveedor;
		
		IF sqlca.sqlcode = 0 THEN
			if isnull(moneda) then moneda = ""
			if isnull(forma_pago) then forma_pago = ""
			if isnull(dtopp) then dtopp = 0
			if isnull(dto1) then dto1 = 0
			if isnull(decimales_precios) then decimales_precios = 0
			
			cambio = f_cambio_moneda(moneda)
					
			this.setitem(row,"moneda",moneda)
			this.setitem(row,"forma_pago",forma_pago)
			This.SetItem(row,"dtopp",dtopp)
			This.SetItem(row,"dto1",dto1)
			This.SetItem(row,"decimales_precios",decimales_precios)
			This.SetItem(row,"cambio",cambio)		
			
			em_precio.setmask(decimalmask!,f_mascara_decimales(decimales_precios))
			em_imp.setmask(decimalmask!,f_mascara_moneda(moneda))
			st_nombre_moneda1.text = f_nombre_moneda_abr(moneda)
			st_nombre_moneda2.text = f_nombre_moneda_abr(moneda)
			f_mascara_columna(dw_1,"precio",f_mascara_decimales(decimales_precios))
		ELSE
			this.setitem(row,"moneda","")
			this.setitem(row,"forma_pago","")
			This.SetItem(row,"dtopp","")
			This.SetItem(row,"dto1","")
			This.SetItem(row,"decimales_precios",0)
			This.SetItem(row,"cambio",1)
		END IF
		//Control albaran del proveedor
		albaran_proveedor = this.object.albaran_proveedor[row]
		if isnull(proveedor) then proveedor = ""
		anyo              = this.object.anyo[row]
		albaran           = this.object.albaran[row]
		fecha_alb         = this.object.fecha_alb[row]
		
		if trim(albaran_proveedor) <> "" and trim(proveedor) <> "" then		
			select count(*)
			into   :existe_albaran
			from   comcabalb
			where  empresa           = :codigo_empresa
			and    proveedor         = :proveedor
			and    albaran_proveedor = :albaran_proveedor
			and    fecha_alb         = :fecha_alb
			and    (anyo            <> :anyo
			or     albaran          <> :albaran);
			
			if isnull(existe_albaran) then existe_albaran = 0
			
			if existe_albaran > 0 then
//				sel = "select albaran,anyo "+&
//						"from comcabalb "+&
//						"where empresa         = '"+codigo_empresa+"' "+&
//						"and proveedor         = '"+proveedor+"' "+&
//						"and albaran_proveedor = '"+albaran_proveedor+"' "+&
//						"and fecha_alb         = '"+string(fecha_alb,formato_fecha_cursores)+"' "+&
//						"and (anyo            <> '"+string(anyo)+"' "+&
//						"or albaran          <> '"+albaran+"')"

				sel = "select albaran,anyo "+&
						"from comcabalb "+&
						"where empresa         = '"+codigo_empresa+"' "+&
						"and proveedor         = '"+proveedor+"' "+&
						"and albaran_proveedor = '"+albaran_proveedor+"' "+&
						"and fecha_alb         = '"+string(fecha_alb)+"' "+&
						"and (anyo            <> '"+string(anyo)+"' "+&
						"or albaran          <> '"+albaran+"')"
		
						
				//albaranes = f_cargar_cursor(sel)
				f_cargar_cursor_nuevo(sel, albaranes)
				total = albaranes.rowcount()
				mensaje = ""
				for indice = 1 to total
					mensaje = mensaje + albaranes.object.albaran[indice]+&
											  "/"+albaranes.object.anyo[indice]+" "
				next
				destroy albaranes
				if messagebox("Atención","El nº de albaran se corresponde con los albaranes internos~n"+&
							  mensaje+"~n¿Desea continuar?",Question!, YesNo!,2) = 2 Then				
				end if
			end if
		end if
		
	case "albaran_proveedor"
		albaran_proveedor = data
		proveedor         = this.object.proveedor[row]
		if isnull(proveedor) then proveedor = ""
		anyo              = this.object.anyo[row]
		albaran           = this.object.albaran[row]
		fecha_alb         = this.object.fecha_alb[row]
		
		if trim(albaran_proveedor) <> "" and trim(proveedor) <> "" then		
			select count(*)
			into   :existe_albaran
			from   comcabalb
			where  empresa           = :codigo_empresa
			and    proveedor         = :proveedor
			and    albaran_proveedor = :albaran_proveedor
			and    fecha_alb         = :fecha_alb
			and    (anyo            <> :anyo
			or     albaran          <> :albaran);
			
			if isnull(existe_albaran) then existe_albaran = 0
			
			if existe_albaran > 0 then
//				sel = "select albaran,anyo "+&
//						"from comcabalb "+&
//						"where empresa         = '"+codigo_empresa+"' "+&
//						"and proveedor         = '"+proveedor+"' "+&
//						"and albaran_proveedor = '"+albaran_proveedor+"' "+&
//						"and fecha_alb         = '"+string(fecha_alb,formato_fecha_cursores)+"' "+&
//						"and (anyo            <> '"+string(anyo)+"' "+&
//						"or albaran          <> '"+albaran+"')"
				sel = "select albaran,anyo "+&
						"from comcabalb "+&
						"where empresa         = '"+codigo_empresa+"' "+&
						"and proveedor         = '"+proveedor+"' "+&
						"and albaran_proveedor = '"+albaran_proveedor+"' "+&
						"and fecha_alb         = '"+string(fecha_alb)+"' "+&
						"and (anyo            <> '"+string(anyo)+"' "+&
						"or albaran          <> '"+albaran+"')"

						
				//albaranes = f_cargar_cursor(sel)
				f_cargar_cursor_nuevo(sel, albaranes)
				total = albaranes.rowcount()
				mensaje = ""
				for indice = 1 to total
					mensaje = mensaje + albaranes.object.albaran[indice]+&
											  "/"+albaranes.object.anyo[indice]+" "
				next
				destroy albaranes
				if messagebox("Atención","El nº de albaran se corresponde con los albaranes internos~n"+&
							  mensaje+"~n¿Desea continuar?",Question!, YesNo!,2) = 2 Then				
				end if
			end if
		end if
end choose
destroy albaranes
if row > 0 then
	anyo    = this.object.anyo[row]
	albaran = this.object.albaran[row]
	
	select count(*)
	into   :lineas_albaran
	from   comlinalb
	where  empresa = :codigo_empresa
	and    anyo    = :anyo
	and    albaran = :albaran;
	
	if isnull(lineas_albaran) then lineas_albaran = 0
	
	if lineas_albaran > 0 then
		actualizar_cabecera            = true
	end if
end if

pb_actualizar_cabecera.enabled = true

end event

event retrieveend;//string moneda
//int    decimales_precios
//
//if rowcount = 1 then
//	moneda            = this.object.moneda[1]
//	decimales_precios = this.object.decimales_precios[1]
//	
//	em_precio.setmask(decimalmask!,f_mascara_decimales(decimales_precios))
//	em_imp.setmask(decimalmask!,f_mascara_moneda(moneda))
//	st_nombre_moneda1.text = f_nombre_moneda_abr(moneda)
//	st_nombre_moneda2.text = f_nombre_moneda_abr(moneda)
//	f_mascara_columna(dw_1,"precio",f_mascara_decimales(decimales_precios))
//end if
end event

type gb_2 from groupbox within w_mant_comlinalb
integer x = 1006
integer y = 128
integer width = 3973
integer height = 376
integer taborder = 100
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 12632256
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type cb_1 from commandbutton within w_mant_comlinalb
boolean visible = false
integer x = 4242
integer y = 2548
integer width = 539
integer height = 76
integer taborder = 250
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Confirmar (antiguo)"
end type

event clicked;str_parametros lstr_param
lstr_param.i_nargumentos= 4
lstr_param.s_argumentos[2]= em_anyo2.text
lstr_param.s_argumentos[3]= em_alb.text
if dw_2.rowcount() = 1 then
	lstr_param.s_argumentos[4]= dw_2.object.proveedor[1]
end if

OpenWithParm(w_confirmacion_alb, lstr_param)



end event

type em_cantidad from u_em_campo within w_mant_comlinalb
integer x = 1701
integer y = 2512
integer width = 507
integer taborder = 190
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = ""
end type

event modified;dec    precio,importe,descuento,cantidad
String moneda_albaran,mascara_moneda

moneda_albaran   = Trim(dw_2.GetItemString(1,"moneda"))
mascara_moneda   = f_mascara_moneda(moneda_albaran)
precio           = dec(em_precio.text)
descuento        = dec(em_descuento.text)
cantidad         = dec(this.text)

importe = dec(string(cantidad * precio,mascara_moneda))

if descuento <> 0 then
	importe = importe - ((importe / 100) * descuento)
	importe = dec(string(importe,mascara_moneda))
end if

em_imp.text = string(importe)
end event

type gb_3 from groupbox within w_mant_comlinalb
integer x = 3342
integer y = 2652
integer width = 759
integer height = 120
integer taborder = 150
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_mant_comlinalb
integer x = 2665
integer y = 2576
integer width = 677
integer height = 196
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type st_nombre_moneda1 from statictext within w_mant_comlinalb
integer x = 3067
integer y = 2520
integer width = 46
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "€"
boolean focusrectangle = false
end type

type st_nombre_moneda2 from statictext within w_mant_comlinalb
integer x = 4105
integer y = 2520
integer width = 78
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "€"
boolean focusrectangle = false
end type

type pb_borraralb from picturebutton within w_mant_comlinalb
integer x = 23
integer y = 344
integer width = 183
integer height = 152
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "c:\bmp\delete.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;cb_borraralb.triggerevent(clicked!)
end event

type cb_borraralb from commandbutton within w_mant_comlinalb
event clicked pbm_bnclicked
integer x = 206
integer y = 344
integer width = 782
integer height = 152
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Borrar albarán"
end type

event clicked;long li
Boolean ok
String alm_entra,automatico,var_ubicado
long   opcion,opcion1
string anyo_alb,cod_alb,anyo_ped,ped,linped
dec    var_precio


if em_anyo2.text="" then
	em_anyo2.setfocus()
	return
end if
if em_alb.text="" then
	em_alb.setfocus()
	return
end if

opcion = messagebox("Borrar Albarán","Desea borrar el albarán "+em_anyo2.text+"/"+em_alb.text +" y todas sus lineas.",question!,yesno!)

if opcion = 1 then
	IF Not f_bloquear_almacen_compras(w_mant_comlinalb.title) Then
		opcion1 = messagebox("Borrar Albarán","Desea restituir las lineas que provengan de pedido en su correspondiente pedido",question!,yesno!)
		
		lin.proveedor = dw_2.GetItemString(1,"proveedor")
		ok = true	
		FOR li=1 TO dw_1.rowcount()
				anyo_ped = dw_1.getitemstring(li,"anyo_pedido")
				ped      = dw_1.getitemstring(li,"pedido")
				linped   = dw_1.getitemstring(li,"linea_pedido")
				
				if isnull(anyo_ped) then anyo_ped = ""
				if isnull(ped) then ped = ""
				if isnull(linped) then linped = ""
				
				IF opcion1 = 1 THEN
					if trim(anyo_ped) <> "" and trim(ped) <> "" and trim(linped) <> "" then
						if not(f_restituir(li,0)) then
							ok = false
						end if
					end if
				END IF
				lin.anyo           = dw_1.getitemstring(li,"anyo")
				lin.albaran        = dw_1.getitemstring(li,"albaran")
				lin.linea          = dw_1.getitemstring(li,"linea")
				lin.mprima         = dw_1.getitemstring(li,"mprima")
				lin.cantidad       = dw_1.getitemnumber(li,"cantidad")
				lin.precio         = dw_1.getitemnumber(li,"precio")
				lin.observaciones  = dw_1.getitemstring(li,"observaciones")
				lin.envase         = dw_1.getitemstring(li,"envase")
				automatico			 = dw_1.getitemstring(li,"automatico")
				var_ubicado        = dw_1.getitemstring(li,"ubicado")
				var_precio		    = dw_1.getitemdecimal(li,"precio")
				
				if automatico = "S" then 
					f_mensaje ("Borrado del albarán",&
						"El albarán no se puede borrar porque se generó automáticamente, en la expedición de un pedido con líneas de mercaderías.")
					ok = false
					exit
				end if
//				IF f_control_almacen(codigo_empresa,lin.mprima) = "S" and var_ubicado = "S" THEN
//					if not(f_salida_almacen(lin.mprima,"1",lin.cantidad,lin.envase,var_precio)) then
//						ok = false
//					end if
//				END IF
		NEXT
		
		IF ok = TRUE then
			anyo_alb=em_anyo2.text
			cod_alb=em_alb.text
			DELETE FROM comcabalb  
			WHERE ( comcabalb.empresa = :codigo_empresa ) AND  
					( comcabalb.anyo 	  = :anyo_alb ) AND  
					( comcabalb.albaran = :cod_alb  );
			if sqlca.sqlcode<>0 then ok = false
				
			DELETE FROM comlinalb  
			WHERE ( comlinalb.empresa = :codigo_empresa ) AND  
					( comlinalb.anyo 	  = :anyo_alb ) AND  
					( comlinalb.albaran = :cod_alb  );
			if sqlca.sqlcode<>0 then ok = false
		END IF
				
		if ok then
			commit;
		else
			messagebox("Error al borrar albaran","El proceso no se actualiza")
			rollback;		
		end if
		
		parent.triggerevent("ue_recuperar")
		
		em_alb.text=""
		em_alb.setfocus()
		
		f_desbloquear_almacen_compras(w_mant_comlinalb.title)
	end if
end if
			
			
			
			
end event

type gb_89 from groupbox within w_mant_comlinalb
integer x = 9
integer y = 308
integer width = 987
integer height = 196
integer taborder = 120
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type cb_newalb from commandbutton within w_mant_comlinalb
event clicked pbm_bnclicked
boolean visible = false
integer x = 18
integer y = 344
integer width = 549
integer height = 76
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Albarán SIN Pedido"
end type

event clicked;if em_anyo2.text="" then
	em_anyo2.setfocus()
	return
end if
if em_alb.text="" then
	em_alb.setfocus()
	return
end if

IF Not f_existe_albaran() THEN
	dw_2.SetItem(1,"empresa",codigo_empresa)
	dw_2.enabled = TRUE
	dw_2.scrolltorow(dw_2.InsertRow(dw_2.getrow()))
	dw_2.SetColumn(1)
	dw_2.SetItem(1,"empresa",codigo_empresa)
	dw_2.SetItem(1,"anyo",em_anyo2.text)
	dw_2.SetItem(1,"albaran",em_alb.text)
	dw_2.setfocus()
END IF

end event

type pb_salir_lineas_pedidos from picturebutton within w_mant_comlinalb
boolean visible = false
integer x = 23
integer y = 2760
integer width = 87
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "\bmp\salir1.bmp"
end type

event clicked;cb_salir_lineas_pedidos.triggerevent(clicked!)
end event

type cb_salir_lineas_pedidos from u_boton within w_mant_comlinalb
boolean visible = false
integer x = 110
integer y = 2760
integer width = 1659
integer height = 84
integer taborder = 40
boolean bringtotop = true
string text = "Cerrar"
end type

event clicked;dw_lineas_pedidos.visible        = false
this.visible                     = false
pb_salir_lineas_pedidos.visible  = false
cb_grabar_lineas_pedidos.visible = false
pb_grabar_lineas_pedidos.visible = false

em_cantidad.text         = "0"
em_precio.text           = "0"
em_descuento.text        = "0"
em_imp.text              = "0"
em_descripcion.text      = ""
em_fechaent.text         = ""
uo_prima.em_codigo.text  = ""
uo_prima.em_campo.text   = ""
uo_medida.em_codigo.text = ""
uo_medida.em_campo.text  = ""
uo_envase.em_codigo.text = ""
uo_envase.em_campo.text  = ""

cb_borrar.enabled			= false
cb_grabar.enabled			= false
cb_sal.enabled 			= false
cb_insertar.enabled		= TRUE
uo_prima.enabled 			= false
uo_medida.enabled 		= false
uo_envase.enabled 		= false
em_cantidad.enabled 		= false
em_fechaent.enabled 		= false
em_precio.enabled 		= false
em_descuento.enabled 	= false
em_descripcion.enabled	= false

cb_newalb.enabled				      = false
cb_borraralb.enabled			      = true
cb_anyadir_desde_pedidos.enabled	= true
em_anyo2.enabled				      = true
em_alb.enabled					      = true
end event

type pb_grabar_lineas_pedidos from picturebutton within w_mant_comlinalb
boolean visible = false
integer x = 1778
integer y = 2760
integer width = 87
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "\bmp\check.bmp"
end type

event clicked;cb_grabar_lineas_pedidos.triggerevent(clicked!)
end event

type cb_grabar_lineas_pedidos from u_boton within w_mant_comlinalb
boolean visible = false
integer x = 1865
integer y = 2760
integer width = 1655
integer height = 84
integer taborder = 30
boolean bringtotop = true
string text = "Grabar lineas seleccionadas"
end type

event clicked;if f_anyadir_lineas_pedidos() then
	commit;
	dw_1.Retrieve(codigo_empresa,em_anyo2.text,em_alb.Text)
	dw_2.Retrieve(codigo_empresa,em_anyo2.text,em_alb.Text)
	cb_anyadir_desde_pedidos.triggerevent(clicked!)
else
	rollback;
	messagebox("Atención","No se actualiza.")
end if
end event

type pb_actualizar_cabecera from picturebutton within w_mant_comlinalb
integer x = 4800
integer y = 344
integer width = 165
integer height = 148
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "11"
string picturename = "c:\bmp\check.bmp"
string disabledname = "c:\bmp\check_no.bmp"
alignment htextalign = left!
end type

event clicked;
if messagebox("Confirmación","¿Desea grabar los cambios realizados en la cabecera del albarán?",Question!,YesNo!,2) = 1 then
	if dw_2.update() = -1 then
		messagebox("Error!!","Se ha producido un error al actualizar la cabecera.~n"+sqlca.sqlerrtext)
		rollback;
	else
		actualizar_cabecera = false
		commit;
		this.enabled = false
	end if			
end if
end event

type st_descuento from statictext within w_mant_comlinalb
integer x = 3122
integer y = 2436
integer width = 224
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12639424
boolean enabled = false
string text = "% Dto"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_seccion from statictext within w_mant_comlinalb
integer x = 1879
integer y = 2604
integer width = 681
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12639424
boolean enabled = false
string text = "Sección"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type uo_seccion from u_em_campo_2 within w_mant_comlinalb
integer x = 1879
integer y = 2688
integer width = 782
integer taborder = 60
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;
this.em_campo.text = f_nombre_contaseccion(codigo_empresa,this.em_codigo.text)

If Trim(this.em_campo.text) = "" Then	
	this.em_campo.text  = ""
	this.em_codigo.text = ""
	this.em_campo.SetFocus()
end if

end event

event getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_contaseccion"
ue_titulo     =  "AYUDA SELECCIÓN DE SECCIONES"
ue_filtro     =  ""
valor_empresa = TRUE
end event

on uo_seccion.destroy
call u_em_campo_2::destroy
end on

type pb_seccion from picturebutton within w_mant_comlinalb
integer x = 2560
integer y = 2604
integer width = 101
integer height = 84
integer taborder = 220
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "c:\bmp\carpeta.bmp"
alignment htextalign = left!
end type

event clicked;str_parametros lstr_param

lstr_param.i_nargumentos    = 1
lstr_param.s_argumentos[1]  = "w_mant_comlinpedpro2"

OpenWithParm(w_mant_contaseccion,lstr_param)

end event

type st_cuenta from statictext within w_mant_comlinalb
integer x = 5
integer y = 2780
integer width = 1751
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12639424
boolean enabled = false
string text = "Cuenta"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type pb_cuenta from picturebutton within w_mant_comlinalb
integer x = 1755
integer y = 2780
integer width = 87
integer height = 76
integer taborder = 180
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "c:\bmp\carpeta.bmp"
end type

event clicked;str_parametros lstr_param

lstr_param.i_nargumentos    = 1
lstr_param.s_argumentos[1]  = "w_mant_comlinalb"

OpenWithParm(w_mant_venmprima2,lstr_param)  

end event

type uo_cuenta from u_em_campo within w_mant_comlinalb
integer x = 9
integer y = 2856
integer width = 379
integer taborder = 20
fontcharset fontcharset = ansi!
string mask = "!!!!!!!!!!"
end type

event getfocus;call super::getfocus;
ue_titulo = "Selección de Cuentas"
ue_datawindow ="dw_ayuda_contaplan_directo"
ue_filtro     = "ejercicio = "+em_anyo2.text

end event

event modificado;call super::modificado;st_nom.text=f_nombre_contaplan(f_ejercicio_activo(codigo_empresa),codigo_empresa,uo_cuenta.text)
If Trim(st_nom.text)="" then
	st_nom.text=""
	uo_cuenta.text=""
	Return
end if 


end event

type st_nom from statictext within w_mant_comlinalb
integer x = 398
integer y = 2864
integer width = 1449
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 28114425
boolean enabled = false
boolean border = true
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_mant_comlinalb
integer x = 9
integer y = 508
integer width = 4969
integer height = 1920
string dataobject = "dw_comlinalb"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;

IF Row = 0 Then Return
this.selectrow(0,false)
this.selectrow(row,true)
if this.getitemstring(row,"ubicado") <> "S" then	
	cb_grabar.enabled      = TRUE
	cb_borrar.enabled      = TRUE
	cb_sal.enabled         = TRUE
	uo_prima.enabled       = TRUE
	uo_medida.enabled      = TRUE
	uo_envase.enabled      = TRUE
	em_cantidad.enabled    = TRUE
	em_fechaent.enabled    = TRUE
	em_precio.enabled      = TRUE
	em_descuento.enabled   = TRUE
	em_descripcion.enabled = TRUE
	
	uo_cuenta.text = this.GetItemString(Row,"comlinalb_cuenta")
	st_nom.text = this.GetItemString(Row,"contaplan_titulo")
	uo_prima.em_codigo.text    = this.GetItemString(Row,"mprima")
	em_descripcion.text        = this.GetItemString(Row,"descripcion")
	uo_prima.em_campo.text     = f_nombre_mprima(codigo_empresa,uo_prima.em_codigo.text)
	em_cantidad.text           = string(this.GetItemNumber(Row,"cantidad"))
	em_precio.text             = String(this.object.precio[row])
	em_descuento.text          = string(this.object.comlinalb_descuento[row])
	em_fechaent.text           = String(date(this.GetItemDateTime(Row,"fecha_entrega")))
	uo_medida.em_codigo.text   = this.GetItemString(Row,"unidad_medida")
	uo_medida.em_campo.text    = f_nombre_unimedida(uo_medida.em_codigo.text)
	uo_envase.em_codigo.text   = this.GetItemString(Row,"envase")
	uo_envase.em_campo.text    = f_nombre_envase(uo_envase.em_codigo.text)
	numlinea                   = this.GetItemString(Row,"linea")
	numrow                     = row
	
	em_imp.text                = string(this.GetItemNumber(Row,"comlinalb_importe"))
	uo_prima.ue_valor_anterior = uo_prima.em_campo.text
	uo_prima.em_campo.SetFocus()
	uo_prima.em_campo.SelectText(1,Len(uo_prima.em_campo.Text))
	
	uo_seccion.em_codigo.text  = this.object.seccion[row]
	uo_seccion.em_campo.text   = f_nombre_contaseccion(codigo_empresa,uo_seccion.em_codigo.text)
	uo_seccion.ue_valor_anterior = uo_seccion.em_codigo.text
	
	cb_newalb.enabled                = false
	cb_borraralb.enabled             = false
	cb_anyadir_desde_pedidos.enabled = false
	em_anyo2.enabled                 = false
	em_alb.enabled                   = false
else
	cb_borrar.enabled = TRUE	
end if

this.setrow(row)

end event

event itemchanged;dec    precio,importe,cantidad,descuento
string moneda


if dwo.name = "precio" or dwo.name = "comlinalb_descuento" then
	if dwo.name = "precio" then
		precio    = dec(data)
		descuento = this.object.comlinalb_descuento[row]
	else
		precio    = this.object.precio[row]		
		descuento = dec(data)
	end if
	cantidad  = this.object.cantidad[row]
	
	
	if dw_2.rowcount() = 1 then
		moneda = dw_2.object.moneda[1]
	end if
	importe    = dec(string(precio * cantidad,f_mascara_moneda(moneda)))
	
	if descuento <> 0 then
		importe = importe - ((importe / 100) * descuento)
		importe = dec(string(importe,f_mascara_moneda(moneda)))
	end if
	
	this.object.comlinalb_importe[row] = importe
	
	this.update()
end if
end event

type dw_lineas_pedidos from datawindow within w_mant_comlinalb
boolean visible = false
integer x = 5
integer y = 1524
integer width = 4187
integer height = 1336
integer taborder = 140
string dataobject = "dw_selec_lineas_pedidos_para_albaran"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type em_descuento from u_em_campo within w_mant_comlinalb
integer x = 3122
integer y = 2512
integer width = 224
integer taborder = 230
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "##0.00"
end type

event modified;dec    precio,importe,descuento,cantidad
String moneda_albaran,mascara_moneda

moneda_albaran   = Trim(dw_2.GetItemString(1,"moneda"))
mascara_moneda   = f_mascara_moneda(moneda_albaran)
precio           = dec(em_precio.text)
descuento        = dec(this.text)
cantidad         = dec(em_cantidad.text)

importe = dec(string(cantidad * precio,mascara_moneda))

if descuento <> 0 then
	importe = importe - ((importe / 100) * descuento)
	importe = dec(string(importe,mascara_moneda))
end if

em_imp.text = string(importe)
end event

type cb_2 from commandbutton within w_mant_comlinalb
string tag = "Procesa las entradas de almacen"
integer x = 3538
integer y = 2772
integer width = 562
integer height = 76
integer taborder = 260
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ubicaciones"
end type

event clicked;string articulo

dw_existencias.visible = not dw_existencias.visible 

if dw_1.Rowcount() > 0 then
	articulo = dw_1.object.mprima[dw_1.Getrow()]
	dw_existencias.retrieve(codigo_empresa, articulo)
else
	messagebox("", "No hay seleccionado ningún artículo de compra")
end if

end event

type dw_existencias from datawindow within w_mant_comlinalb
boolean visible = false
integer x = 3584
integer y = 1908
integer width = 1294
integer height = 448
integer taborder = 150
boolean bringtotop = true
string title = "none"
string dataobject = "dw_con_existencias_compras"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event itemchanged;long linea

this.SetRowFocusIndicator(p_cursor)
IF this.getRow()<>0 THEN
 	linea     = dw_existencias.GetRow() 
 	IF linea<>0 THEN
		This.SelectRow(0,FALSE)
		This.SelectRow(row,TRUE)
		this.setrow(row)
  	End If
End IF
 


end event

type p_cursor from picture within w_mant_comlinalb
integer x = 4091
integer y = 204
integer width = 73
integer height = 64
boolean originalsize = true
string picturename = "VCRNext!"
boolean focusrectangle = false
end type

