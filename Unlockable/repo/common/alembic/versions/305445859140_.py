"""empty message

Revision ID: 305445859140
Revises: 43d99ea4984a
Create Date: 2013-10-12 13:37:08.990155

"""

# revision identifiers, used by Alembic.
revision = '305445859140'
down_revision = '43d99ea4984a'

from alembic import op
import sqlalchemy as sa


def upgrade():
    ### commands auto generated by Alembic - please adjust! ###
    op.add_column('sitting', sa.Column('user_agent', sa.String(length=256), nullable=True))
    ### end Alembic commands ###


def downgrade():
    ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('sitting', 'user_agent')
    ### end Alembic commands ###
