"""empty message

Revision ID: 5346e6152e6b
Revises: 42a6d2b5f1d1
Create Date: 2013-04-30 16:45:25.157048

"""

# revision identifiers, used by Alembic.
revision = '5346e6152e6b'
down_revision = '42a6d2b5f1d1'

from alembic import op
import sqlalchemy as sa


def upgrade():
    ### commands auto generated by Alembic - please adjust! ###
    op.add_column('commercial', sa.Column('brand_image', sa.String(length=256), nullable=False, server_default=""))
    ### end Alembic commands ###


def downgrade():
    ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('commercial', 'brand_image')
    ### end Alembic commands ###
